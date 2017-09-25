From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Sep 2017 12:10:27 +0200
Subject: [PATCH 0/3] Simple DVFS support for Allwinner A64 SoC
In-Reply-To: <20170923001531.14285-1-icenowy@aosc.io>
References: <20170923001531.14285-1-icenowy@aosc.io>
Message-ID: <20170925101027.lghnnll4h6inreqm@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Sep 23, 2017 at 12:15:28AM +0000, Icenowy Zheng wrote:
> This patchset imports simple DVFS support for Allwinner A64 SoC.
> 
> As the thermal sensor driver is not yet implemented and some boards
> have still no AXP PMIC support, now only two OPPs are present --
> 648MHz at 1.04V and 816MHz at 1.1V to prevent overheat or undervoltage.
> 
> PATCH 1 is a fix to the CCU driver of A64, and the remaining patches
> set up the device tree bits of the DVFS on Pine64.

How has this been tested?

What tasks did you run, with what governor, etc...

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/2db44b0f/attachment.sig>
