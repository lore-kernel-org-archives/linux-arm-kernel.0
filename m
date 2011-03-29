From: marek.belisko@gmail.com (Belisko Marek)
Date: Tue, 29 Mar 2011 09:23:10 +0200
Subject: [PATCH 0/4] s3c2440: mini2440: Add missing code parts to be fully
	working with latest kernel.
In-Reply-To: <AANLkTin9PZuJpy4CizGvw4w6nexrdr1h+yPTU2vwjTBV@mail.gmail.com>
References: <1301380363-3282-1-git-send-email-marek.belisko@open-nandra.com>
	<AANLkTin9PZuJpy4CizGvw4w6nexrdr1h+yPTU2vwjTBV@mail.gmail.com>
Message-ID: <AANLkTi=f-6tVRxiDLQhbCj_wmdzd2X7+pVzYFs+-6v5O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 9:20 AM, M P <buserror@gmail.com> wrote:
> On Tue, Mar 29, 2011 at 7:32 AM, Marek Belisko
> <marek.belisko@open-nandra.com> wrote:
>> Patch add new LCD panels with which was board produced. Also add touchscreen
>> support. Enabling LCD backlight during early booting stage also added.
>>
>> Some code parts are collected or inspired from other code (authors are in CC).
>
> Actually, I'm not in CC, and most of this was from my own mini2440
> tree on repo.or.cz, I'm also listed as maintainer at the bottom of the
> mach-mini2440.c file.
If you were not on CC how you get this email? I don't care about maintainers at
the bottom of file. I just check get_maintainer.pl script.
>
> Michael
>
>> Marek Belisko (4):
>> ?s3c2440: mini2440: Add support for new LCD panels.
>> ?s3c2440: mini2440: Add touchscreen support for mini2440.
>> ?s3c2440: mini2440: Select touchscreen by default.
>> ?s3c2440: mini2440: Enable the backlight LED earlier at boot time.
>>
>> ?arch/arm/mach-s3c2410/include/mach/leds-gpio.h | ? ?1 +
>> ?arch/arm/mach-s3c2440/Kconfig ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-s3c2440/mach-mini2440.c ? ? ? ? ?| ? 55 +++++++++++++++++++++++-
>> ?drivers/leds/leds-s3c24xx.c ? ? ? ? ? ? ? ? ? ?| ? ?6 ++-
>> ?4 files changed, 60 insertions(+), 3 deletions(-)
>>
>>
>

regards,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
icq: 290551086
web: http://open-nandra.com
