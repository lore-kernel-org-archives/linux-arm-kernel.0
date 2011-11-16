From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 16 Nov 2011 18:08:04 -0500 (EST)
Subject: [PATCH 0/23] mach/vmalloc.h removal, and ioremap optimization
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1740D748BE@HQMAIL01.nvidia.com>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <74CDBE0F657A3D45AFBB94109FB122FF1740D748BE@HQMAIL01.nvidia.com>
Message-ID: <alpine.LFD.2.02.1111161807390.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Nov 2011, Stephen Warren wrote:

> Nicolas Pitre wrote at Tuesday, November 15, 2011 10:48 PM:
> > This patch series removes all instances of mach/vmalloc.h in order to
> > have a more unified memory map across all ARM architectures. ...
> 
> For Tegra, the series:
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> (On Seaboard/Springbank, booted DT, booted non-DT and tested audio, both
> with root filesystem on SD card)

Thanks for testing!


Nicolas
