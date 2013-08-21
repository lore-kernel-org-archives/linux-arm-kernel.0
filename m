From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Aug 2013 05:54:28 -0700
Subject: [PATCH] arm: omap5: hwmod: add missing ocp2scp hwmod data
In-Reply-To: <5214AE69.8010009@baylibre.com>
References: <1373642066-5235-1-git-send-email-balbi@ti.com>
 <20130821074728.GV7656@atomide.com> <52148C67.3080106@baylibre.com>
 <CALpuT30YToRvgS3rgvpSZf8d1DZBK9y5mNUJL6qbHS22mL4k-g@mail.gmail.com>
 <5214AE69.8010009@baylibre.com>
Message-ID: <20130821125427.GL7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Benoit Cousson <bcousson@baylibre.com> [130821 05:18]:
> + Kishon and Roger
> 
> Ok, so in fact that's a complete series now.
> 
> [v2,1/5] arm: omap5: dts: fix reg property size
> [v2,2/5] arm: omap5: dts: fix ocp2scp DTS data
> [v2,3/5] arm: omap5: dts: add palmas-usb node
> [v2,4/5] arm: omap5: hwmod: add missing ocp2scp hwmod data
> [v2,5/5] arm: omap2plus_defconfig: enable dwc3 and dependencies
> 
> Moreover, it does not build because of the change in the palmas SMPS10 regulator name from Kishon I already pulled.
> 
> Kishon or Roger,
> 
> Could you resend that series ASAP after fixing, testing and changing my email address?
> 
> 
> Tony,
> 
> I will need your ack for the omap2plus_defconfig patch. 

OK, acked the v2 of the omap2plus_defconfig patch.

Tony
