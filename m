From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 16 Aug 2011 09:27:05 -0700
Subject: [PATCH] ARM: tegra: Add missing include of linux/erron.h and
	linux/types.h
In-Reply-To: <1313471744.5824.2.camel@phoenix>
References: <1313471744.5824.2.camel@phoenix>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA25328@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin wrote at Monday, August 15, 2011 11:16 PM:
> Include linux/erron.h to fix below build error.
...
> Include linux/types.h to fix below build error.
...
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> This patch is against linux-next (next-20110815), it fixes the build error with "make
> tegra_defconfig".

Axel,

I posted this same thing a little while back. Russell asked me to perform
some rework on gpio.h that removed the need for errno.h instead. I did
that in:

http://www.spinics.net/lists/linux-tegra/msg01996.html

I'm just waiting for an Ack from Grant Likely on the GPIO driver changes,
and then will place the series into the ARM patch system as Russell
requested.

Thanks for caring about Tegra compile issues:-)

-- 
nvpublic
