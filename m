From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon, 18 Aug 2014 23:54:40 +0300
Subject: [GIT PULL] ARM: mvebu: SoC changes for v3.17 (round 2)
In-Reply-To: <20140718220516.GM24496@titan.lakedaemon.net>
References: <20140718220516.GM24496@titan.lakedaemon.net>
Message-ID: <20140818205440.GB2126@drone.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 06:05:16PM -0400, Jason Cooper wrote:
> Yeah, it's just one patch, but it's a beautiful one!  Thanks to the
> efforts of many people over the last couple years, and in particular,
> Andrew Lunn, Kirkwood has been completely converted to DT.

Is there instructions how to get OpenRD Client DT boot to work
with 3.17-rc1? I see that legacy boot has been deleted, so there is
no other option.

I tried booting kernel with appended DTB, but it just silently hangs.
Also tried to enable earlyprintk, but couldn't get even that working...

Can you share the configs using which OpenRD Client DT was tested?

Thanks,

A.
