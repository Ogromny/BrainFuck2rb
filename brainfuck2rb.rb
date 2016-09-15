puts 'https://github.com/Ogromny/BrainFuck2rb'

print 'Brainfuck file: '
brainfuck_file = gets.to_s.chomp

ruby_code = String.new

ruby_code << 'buf = Array.new 65535, 0' + "\n"
ruby_code << 'i = 0' + "\n"

tabs_count = 0

File.open brainfuck_file, 'r' do |f|
    loop do
        c = f.getc

        if c == nil || c == "\n"
            File.write(brainfuck_file + '.rb', ruby_code)
            break
        end

        tabs_count -= 1 if c == "]"

        tabs = "\t" * tabs_count

        tabs_count += 1 if c == "["

        ruby_code <<
            case c.to_s
                when '>' then "#{tabs}i += 1\n"
                when '<' then "#{tabs}i -= 1\n"
                when '+' then "#{tabs}buf[i] += 1\n"
                when '-' then "#{tabs}buf[i] -= 1\n"
                when '.' then "#{tabs}putc buf[i]\n"
                when ',' then "#{tabs}buf[i] = $stdin.readbyte\n"
                when ']' then "#{tabs}end\n"
                when '[' then "#{tabs.chomp}while buf[i] != 0\n"
            end
    end

end