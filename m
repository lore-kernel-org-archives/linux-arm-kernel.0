From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2010 17:26:54 +0000
Subject: [PATCH] iop: use generic clock mult/shift compute functions
In-Reply-To: <19258.8113.311122.46281@pilspetsen.it.uu.se>
References: <19258.8113.311122.46281@pilspetsen.it.uu.se>
Message-ID: <20100108172654.GK32558@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2009 at 04:26:41PM +0100, Mikael Pettersson wrote:
> The 2.6.33-rc kernel now has generic functions for computing
> mult and shift factors for clocksources and clockevents. Thus
> we can remove the equivalent private code from the ARM IOP
> platform and use the generic code instead.
> 
> Tested on an n2100 iop32x machine. Verfied to result in the
> exact same mult and shift factors as before.

Good, can we have it in the patch system please?
