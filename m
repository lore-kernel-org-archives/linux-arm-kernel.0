From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Jul 2017 11:47:27 +0100
Subject: [PATCH v11 0/3]add PCIe driver for Kirin PCIe
In-Reply-To: <20170702233657.GA13507@bhelgaas-glaptop.roam.corp.google.com>
References: <20170619102349.50652-1-songxiaowei@hisilicon.com>
 <20170702233657.GA13507@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170703104727.GB1573@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 02, 2017 at 06:36:57PM -0500, Bjorn Helgaas wrote:
> [+cc Catalin, Will, linux-arm-kernel]
> 
> Applied patches 2 & 3 to pci/host-kirin for v4.13.
> 
> I would like a MAINTAINERS update, too.  If you send me that, I'll
> squash it into the driver patch.
> 
> Catalin, Will, how do you want to handle the
> arch/arm64/configs/defconfig change (patch 3)?  It's currently on my
> branch, but I'm happy to drop it if another route is better.

defconfig updates usually go through arm-soc, via the relevant platform
maintainer, so it would be best to follow that route here too otherwise
you'll probably see conflicts in -next.

Will
