puts "https://github.com/Ogromny/BrainFuck2rb"

puts "\nBrainfuck file: "
input_file  = gets.to_s.chomp

output      = String.new
output_file = input_file + ".rb"

output << "buf = Array.new 65535, 0\n"
output << "i = 0\n"

begin
    file = File.open input_file, "r+"

    tabs = 0

    loop do
        c = file.getc

        break if c == nil || c == "\n"

        str = "\t" * tabs

        output << case c.to_s
        when '>' then "#{str}i += 1\n"
        when '<' then "#{str}i -= 1\n"
        when '+' then "#{str}buf[i] += 1\n"
        when '-' then "#{str}buf[i] -= 1\n"
        when '.' then "#{str}putc buf[i]\n"
        when ',' then "#{str}buf[i] = $stdin.readbyte\n"
        when '[' then tabs += 1; "#{str}while buf[i] != 0\n"
        when ']' then tabs -= 1; "#{str}end\n"
        end
    end
rescue IOError => e
    puts "Error: #{e}"
ensure
    file.close unless file.nil?
end

begin
    ofile = File.new output_file, "w"
    ofile.write output
rescue IOError => e
    puts "Error: #{e}"
ensure
    ofile.close unless file.nil?
end
