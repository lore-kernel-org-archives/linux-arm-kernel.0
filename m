From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Aug 2011 05:49:21 -0700
Subject: [PATCH V4] ARM: tegra: paz00: add clocks required for usb
	operation
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04A068758D@HQMAIL01.nvidia.com>
References: <201108101921.58149.marc.dietrich@ap.physik.uni-giessen.de>
	<74CDBE0F657A3D45AFBB94109FB122FF04A068758D@HQMAIL01.nvidia.com>
Message-ID: <20110811124921.GA4664@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2011 at 01:39:58PM -0700, Stephen Warren wrote:
> Marc Dietrich wrote at Wednesday, August 10, 2011 11:22 AM:
> > These clocks are required for usb operation. pll_p_out4 needs to be set
> > to 24 MHz. The other clocks default to "off" in order to save some energy.
> > 
> > Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Given the rest of the thread, this is fine for now. We can address any
> deficiencies in the bus clock and clk_m parenting when it's addressed
> globally for all boards later.

Agreed; I don't have good access to hardware while on vacation, so I won't
be able to test and post the clock change patches until towards the end of next
week.

I've applied and pushed this patch out to boards-for-3.2 meanwhile.


-Olof
