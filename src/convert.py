#!/usr/bin/env python3

import argparse
import os


def convert(input_path, output_path):
    if not os.path.exists(output_path):
        os.mkdir(output_path)
    with open(input_path) as f:
        outfile = None
        for line in f:
            if line.strip() == "```":
                if outfile:
                    outfile.close()
                    outfile = None
            elif line.startswith("```"):
                file_name = line.split()[1]
                file_path = os.path.join(output_path, file_name)
                outfile = open(file_path, "w")
            elif outfile:
                if line.startswith("# IMPORT "):
                    file_path = line.split()[2]
                    with open(file_path) as g:
                        for l in g:
                            outfile.write(l)
                else:
                    outfile.write(line)


def main():
    parser = argparse.ArgumentParser(description="Convert Markdown to multiple files")
    parser.add_argument("input", type=str, help="The input Markdown file")
    parser.add_argument("output", type=str, help="The output directory")
    args = parser.parse_args()

    convert(args.input, args.output)


if __name__ == "__main__":
    main()
