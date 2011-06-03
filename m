From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 03 Jun 2011 11:51:48 +0530
Subject: [GIT PULL] scalable TWD localtimer
In-Reply-To: <BANLkTikYRk6ZKaZnTt4NFiDSnbN+jyNT-Q@mail.gmail.com>
References: <BANLkTik0TVpfax1Fe8c_6A9SFUNzfDbxyw@mail.gmail.com>	<4DE87085.1090901@ti.com>
	<BANLkTikYRk6ZKaZnTt4NFiDSnbN+jyNT-Q@mail.gmail.com>
Message-ID: <4DE87D7C.60609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/3/2011 11:46 AM, Colin Cross wrote:
> On Thu, Jun 2, 2011 at 10:26 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com>  wrote:
>> Linus,
>>
[...]

>
> I will submit the Tegra clock change along with a separate series.
> This change should not change any functionality on platforms where the
> clock has not been defined, so there is no need to sequence it with
> clock patches.

Agree. My intention was same bug get fixed on all platforms together
in one series. Ofcourse the platform non supporting CPUFreq in mainline
shouldn't care too much either.

Sorry for noise.

Regards
Santosh
