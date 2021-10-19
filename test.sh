set -eux

command -v ruby
ruby -v
command -v gemirro
gemirro --version

gemirro init "$(pwd)"
cp -p fixtures/gems/a/a-0.0.1.gem public/gems/

sleep 1
gemirro update
gemirro index
gemirro list

pkill gemirro || :
sleep 1
gemirro server --start
sleep 1

echo "pid: $(cat gemirro.pid)"
gemirro server --status

bundle install --standalone

gemirro server --stop
echo "OK"
