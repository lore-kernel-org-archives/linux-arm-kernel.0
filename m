From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Jul 2012 23:51:49 -0700
Subject: [GIT PULL 2/5] omap board changes for v3.6 merge window
In-Reply-To: <4FFCCE43.2070709@windriver.com>
References: <0M4ZFU-1RqIwX3VUq-00yonj@mx.kundenserver.de>
 <201207101534.13166.arnd@arndb.de> <4FFCCE43.2070709@windriver.com>
Message-ID: <20120711065149.GB1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Zumeng Chen <zumeng.chen@windriver.com> [120710 17:57]:
> ? 2012?07?10? 23:34, Arnd Bergmann ??:
> >I got a conflict in arch/arm/mach-omap2/common-board-devices.c between
> >16aced80f6739 "ARM: OMAP3530evm: set pendown_state and debounce time for
> >ads7846" and 97ee9f01d6f26 "ARM: OMAP: fix the ads7846 init code",
> >see my resolution below.
> >
> >Please check if what I have in the for-next branch makese sense to you
> >all.
>
> No problem,  many thanks Arnd for your information.
> I'll check it, test it, and send you feedback.

Thanks, looks good. Also I've checked that for-next builds fine with
my testconfigs.

Regards,

Tony
