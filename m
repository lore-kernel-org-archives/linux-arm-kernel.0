From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Oct 2011 20:20:57 +0100
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <alpine.LFD.2.02.1110141353390.17040@xanadu.home>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<201110141729.41515.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
	<201110141827.53906.arnd@arndb.de>
	<alpine.LFD.2.02.1110141353390.17040@xanadu.home>
Message-ID: <20111014192057.GT21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 02:01:07PM -0400, Nicolas Pitre wrote:
> The way I'm restructuring things around this is that AUTO_ZRELADDR will 
> always be active by default, just like ARM_PATCH_PHYS_VIRT now.  This 
> platform specific exclusion thinking is a step backward so I'd prefer if 
> people would refrain from going there for the moment.

Are you expecting everyone to change the way they load the zImage
overnight then?
