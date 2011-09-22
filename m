From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 22 Sep 2011 20:58:00 +0300
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1739554CB9@HQMAIL01.nvidia.com>
References: <1316698045-23190-1-git-send-email-pdeschrijver@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1739554CB9@HQMAIL01.nvidia.com>
Message-ID: <20110922175800.GC21166@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 06:26:36PM +0200, Stephen Warren wrote:
> Peter De Schrijver wrote at Thursday, September 22, 2011 7:27 AM:
> > This patch causes the kernel uncompressor to determine the physical address
> > of the SDRAM at runtime. This allows the kernel to boot on both tegra2 and
> > tegra3 even though SDRAM is at different physical addresses on both SoCs.
> 
> Since this deals with Tegra, it should be mailed to/cc the Tegra
> Maintainers and mailing list too (I've done that here). get_maintainer.pl
> will no doubt list the main linux-kernel mailing list too.
> 
> > Change-Id: I91857a590946bbc54168c04bea3a5bd576d87824
> 
> And the internal Change-Id lines should be stripped for upstream
> submissions.
> 

Auw indeed. I did it for the previous round, but I really need to write a
script to do this :)

Cheers,

Peter.
