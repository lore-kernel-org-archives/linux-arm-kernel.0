From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 2 Jun 2011 09:40:50 -0600
Subject: [RFC 2/2] ARM:Tegra: Device Tree Support: Initialize audio card
	gpio's from the device tree.
In-Reply-To: <20110601161856.GB15583@opensource.wolfsonmicro.com>
References: <20110530033826.GE4130@opensource.wolfsonmicro.com>
	<20110530061155.GC23517@ponder.secretlab.ca>
	<4DE336A1.5040509@firmworks.com>
	<20110530070138.GA5036@opensource.wolfsonmicro.com>
	<8d2515b13c817cc956b185d043bcef00@kernel.crashing.org>
	<BANLkTi=hkScxYpt449CQCky+bLU3UvkC_A@mail.gmail.com>
	<4DE403C5.7060003@firmworks.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498E1C22D@HQMAIL01.nvidia.com>
	<4DE536AD.5080200@firmworks.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498E1C3F5@HQMAIL01.nvidia.com>
	<20110601161856.GB15583@opensource.wolfsonmicro.com>
Message-ID: <BANLkTinvdwDHtFQ=Pt5bh=OmMjkzffk8dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 10:18 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Jun 01, 2011 at 08:59:55AM -0700, Stephen Warren wrote:
>
>> My perspective is that cut/pasting the entire SoC definition into a board
>> definition is the devicetree equivalent of having more than one driver
>> per chip, not sharing gpio/pinmux/... code, etc. in the kernel; the very
>> stuff that caused Linus to complain about the state of ARM Linux.
>
> Very strongly agreed, we've had to do that in the past because of
> limitations in the device tree infrastructure but if we end up having to
> cut'n'paste that's not going to be great for maintainability.

+2

cut'n'paste is not an option.  period.  :-)

g.


>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
