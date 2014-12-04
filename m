From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Dec 2014 10:40:34 -0800
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201412041934.03384@pali>
References: <20141027200008.GR2560@atomide.com> <201411282241.12095@pali>
 <20141128222424.GX2817@atomide.com> <201412041934.03384@pali>
Message-ID: <20141204184033.GI2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [141204 10:36]:
> 
> see last mail in thread (I CCed you):
> "[PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible"
> 
> There is already some layer for converting ATAGs to DTB and it is 
> in decompresser: arch/arm/boot/compressed/atags_to_fdt.c
> 
> I do not know if it can help us to provide /proc/cpuinfo and 
> /proc/atags in DT boot, but at least this this transfer cmdline 
> and mem ATAGs to DBT.

Yes that makes sense to me. Sorry forgot about that piece of
code as I have not tinkered with arch/arm/boot/compressed/*
for a few years.

It sounds like there may be some regression also if the cmdline
is not being passed like it already should. But I assume you
already figured that out and have some patches coming :)

Regards,

Tony
