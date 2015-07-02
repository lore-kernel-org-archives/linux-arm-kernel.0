From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 3 Jul 2015 00:47:28 +0200
Subject: [PATCH V2 0/5] drivers/rtc/rtc-ds1307.c: Basic cleanups and
 support for wakeupirq
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Message-ID: <20150702224728.GF3467@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/06/2015 at 11:15:09 -0500, Nishanth Menon wrote :
> NOTE1: I have only tested in mcp79410 device, and not on other
> ds1307-rtc driver compatbile devices as I dont have any other.
> additional testing might be nice to have.

Patchwork picked up V3 of 4/5 correctly so I have applied the series and
pushed it in rtc-next. It will land in linux-next tomorrow so hopefully,
this will see more testing.

> NOTE2: there are additional fixes that linux-next seems to need but
> those are in omap-rtc, cpufreq etc, but those are not related by the
> ds-1307.
> 
> V1: https://patchwork.kernel.org/patch/4759171/
> 
> NOTE: Patch 5/5 of the series is meant to indicate the usage, and will
> be reposted along with other wakeup sources to be enabled once the
> driver changes are accepted.
> 

I've left that one out so you can send it to the omap maintainers when
ready.

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
