From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 29 Jun 2011 15:05:28 +0530
Subject: [PATCH V2 0/3] Add drivers/pwm and drivers/pwm/st_pwm.c
In-Reply-To: <20110629091441.GA9349@pengutronix.de>
References: <cover.1306831238.git.viresh.kumar@st.com>
	<201106271526.12848.arnd@arndb.de>
	<20110628100438.GI6069@pengutronix.de>
	<201106281713.16099.arnd@arndb.de>
	<20110629091441.GA9349@pengutronix.de>
Message-ID: <BANLkTik67AoaUMTTGnOuB27Rg55zU-qf=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 2:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Tue, Jun 28, 2011 at 05:13:15PM +0200, Arnd Bergmann wrote:
>> On Tuesday 28 June 2011, Sascha Hauer wrote:
>
> Definitely. From a quick look at the driver it seems the pwms all have
> a seperate register space.
>

Actually, latest version of pwm (not present in current patch) has
common registers to all pwm devices.

> I can add Viresh's patch to my series once we agree on the base patch.
> In the meantime maybe Viresh starts converting it ;)

I will not be able to do this now due to some other activities i am
doing currently. :(
May be you can go ahead with your patchset and i will update mine and
send it back as soon as i get some time.

--
viresh
