file=./hosts.yml
while read var 
do
if [ $(echo $var | wc -w ) -eq 1 ]
then
continue
fi

username=$( echo $var | awk '{ print $3 }' | cut -d'=' -f2)
ip=$( echo  $var | awk '{ print $2 }' | cut -d'=' -f2)
pas=$( echo $var | awk '{ print $6 }' | cut -d'=' -f2)
port=$( echo $var | awk '{ print $4 }' | cut -d'=' -f2)
sshpass -p $pas ssh-copy-id -o StrictHostKeyChecking=no -i /home/strik/.ssh/id_rsa.pub $username@$ip -p $port
done < $file

ansible-playbook playbook.yml

sed -i 's/ansible_port=22/ansible_port=33014/' $file
