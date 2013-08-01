From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 1 Aug 2013 11:26:13 +0200
Subject: [PATCH 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <20130801090721.GU9916@kw.sim.vm.gnt>
References: <1375346738-21596-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375346738-21596-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130801090721.GU9916@kw.sim.vm.gnt>
Message-ID: <20130801112613.76a0f748@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Thu, 1 Aug 2013 11:07:21 +0200, Simon Guinot wrote:

> Thanks for this patch.
> 
> Note that the leds-ns2 drivers has already been converted to DT. Please
> have a look at Documentation/devicetree/bindings/leds/leds-ns2.txt or
> arch/arm/boot/dts/kirkwood-ns2.dts.
> 
> Once the LED part will be removed, you may also consider to move the
> mv643xx_eth initialization into board-ns2.c (and maybe also renaming
> this file into board-lacie.c).

Thanks for this feedback, I'll have a look.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
