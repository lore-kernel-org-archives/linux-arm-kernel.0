From: rubini@gnudd.com (Alessandro Rubini)
Date: Tue, 29 May 2012 08:31:38 +0200
Subject: amba, tegra-ahb and pci (Kconfig question)
In-Reply-To: <4FC435B5.8030007@nvidia.com>
References: <4FC435B5.8030007@nvidia.com>
 <20120528081737.GA8031@mail.gnudd.com>
Message-ID: <20120529063138.GA22542@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> FYI, there's a desire to keep all (especially new) drivers out of
> arch/arm/mach-*. We had originally wanted to put the tegra-ahb driver in
> that directory since it is highly Tegra-specific, but that location was
> NAKd.

Ok. I've seen this trend, actually.  Yesterday I posted the code for
the pci bridge living in drivers/amba besides yours, as Russell
suggested.  I didn't Cc: because it wasn't tegra specific, maybe
I would better have cc'd you.

Thanks
/alessandro
