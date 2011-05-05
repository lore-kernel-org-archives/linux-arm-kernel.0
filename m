From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 5 May 2011 00:35:07 -0600 (MDT)
Subject: Common clock and dvfs
In-Reply-To: <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1105050026420.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 May 2011, Colin Cross wrote:

> Imagine a chip where a clock can feed devices A, B, and C.  If the
> devices are always clocked at the same rate, and can't gate their
> clocks, the minimum voltage that can be applied to a rail is
> determined ONLY by the rate of the clock.

That's not so -- although admittedly it's a side issue, and not 
particularly related to DVFS.

For example, the device may have some external I/O lines which need to be 
at least some minimum voltage level for the externally-connected device to 
function.  This minimum voltage level can be unrelated to the device's 
clock frequency.


- Paul
