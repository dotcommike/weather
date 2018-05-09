mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
cp weather/nginx.conf /etc/nginx/nginx.conf
service nginx start
crontab weather/cron.txt
git clone https://github.com/rghunter/weatherapp.git
pip install --upgrade pip
pip install -r weatherapp/requirements.txt
sed -i '73i WUNDERGROUND_API_KEY = '"'a08c8620e0bc1469'"'' weatherapp/weatherapp/settings.py
python weatherapp/manage.py weatherapp/migrate
python weatherapp/manage.py weatherapp/loadlocations
python weatherapp/manage.py runserver&
