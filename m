From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 03 Sep 2012 17:16:55 +0200
Subject: [PATCHv2 1/3] ARM: dts: mxs: Add missing address and size cells
 in SSP* nodes
In-Reply-To: <20120903144941.GH2362@S2101-09.ap.freescale.net>
References: <1346666749-6094-1-git-send-email-maxime.ripard@free-electrons.com>
 <20120903144941.GH2362@S2101-09.ap.freescale.net>
Message-ID: <5044C9E7.9090901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Le 03/09/2012 16:49, Shawn Guo a ?crit :
> Which tree your patches are based on?  Neither does it apply on v3.6-rc
> nor my mxs/dt-for-3.7 branch.

They are based on 3.6-rc1 + Marek Vasut's patches for SPI ([PATCH v3]
MXS SPI Driver sent the 08/03).

But it looks like the last patch that was never merged, and it was
actually adding the muxing options to the imx28 dtsi file.

I'll remove that patch from my tree and send a new version of this patch.

> Nit: The "*" in subject is not really needed.  "... in SSP nodes" looks
> just fine.

Ok, I will remove it in the next version.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
