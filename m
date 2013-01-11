From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Jan 2013 21:38:24 +0800
Subject: [shawnguo:cleanup/clockevents 2/2] ERROR:
 "clockevents_config_and_register" [drivers/clocksource/cs5535-clockevt.ko]
 undefined!
In-Reply-To: <20130111122424.GB23972@localhost>
References: <50efde33.imTwOnb1rtCKWsgz%yuanhan.liu@linux.intel.com>
 <20130111122424.GB23972@localhost>
Message-ID: <20130111133822.GB24554@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 08:24:24PM +0800, Fengguang Wu wrote:
> 
> Hi Shawn,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.linaro.org/people/shawnguo/linux-2.6.git cleanup/clockevents
> head:   ab8e73c98749a58c242b187c9799db70cd903157
> commit: ab8e73c98749a58c242b187c9799db70cd903157 [2/2] clocksource: use clockevents_config_and_register() where possible
> config: i386-randconfig-b030 (attached as .config)
> 
> All error/warnings:
> 
> >> ERROR: "clockevents_config_and_register" [drivers/clocksource/cs5535-clockevt.ko] undefined!
> 
I will propose a patch to export clockevents_config_and_register() to
fix the error.

Thanks Fengguang.

Shawn
