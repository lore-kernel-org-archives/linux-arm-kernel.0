From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 5 Jan 2018 13:45:35 +0100
Subject: [PATCH 1/7] arm64: dts: marvell: use SPDX-License-Identifier
 for Armada SoCs
In-Reply-To: <20180105134046.12915b36@windsurf.lan>
References: <20180105115329.1233-1-gregory.clement@free-electrons.com>
 <20180105115329.1233-2-gregory.clement@free-electrons.com>
 <20180105134046.12915b36@windsurf.lan>
Message-ID: <20180105134535.3b62ff57@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 5 Jan 2018 13:40:46 +0100, Thomas Petazzoni wrote:

> > diff --git a/arch/arm64/boot/dts/marvell/armada-371x.dtsi b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> > index 11226f7b9ed9..dc1182ec9fa1 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-371x.dtsi
> > @@ -1,3 +1,4 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)  
> 
> The previous license was GPL-2.0+ or X11, not GPL-2.0+ or MIT. Any
> reason to change from X11 to MIT ?

My bad, I should have read the commit log first. Sorry for the noise.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
