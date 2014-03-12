From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Mar 2014 10:22:48 -0700
Subject: [PATCH 0/7] ARM: dts: overo: Add new expansion boards
In-Reply-To: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
References: <1394540435-25401-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20140312172247.GC30897@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Florian Vaussard <florian.vaussard@epfl.ch> [140311 05:24]:
> Hi,
> 
> This series adds the support for 5 new expansion boards from Gumstix:
> - Palo43
> - Gallop43
> - Chestnut43
> - Alto35
> - Summit
> 
> The 1st patch is a preparatory work, in order to factorize some
> peripherals that are common to most Gumstix expansion boards. Patch 2
> adds the support for an accelerometer that is present on most boards.
> 
> Palo43, Gallop43 and Chestnut43 are all pretty similar. I tested
> on a Gallop43 (with both OMAP35xx and OMAP36xx Overo).
> 
> Alto35 is slightly different. Again, I tested with both OMAP35xx and
> OMAP36xx Overo.
> 
> Summit is pretty similar to Tobi. I do not have a Summit at hand,
> but given the similarity with Tobi, it should work fine.
> 
> To avoid unnecessary duplications, I put all the common stuff for each
> board inside an omap3-overo-xxx-common.dsti include file. By doing so,
> I can have minimal SoC-specific omap3-overo-xxx.dts (omap34xx based)
> and omap3-overo-storm-xxx.dts (omap36xx based) device trees.
> 
> This series depends on my previous Overo series [1]. A complete testing
> tree (including the graphics support, soon to be posted) is available
> at [2].

Thanks, applying the whole series into omap-for-v3.15/dt-overo.
As it's this close to the merge window, no guarantees anything
will get pulled in though.

Regards,

Tony
 
> [1] http://thread.gmane.org/gmane.linux.ports.arm.omap/111558
> [2] https://github.com/vaussard/linux.git (overo/for-3.15/review1)
