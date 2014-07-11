From: tj@kernel.org (Tejun Heo)
Date: Fri, 11 Jul 2014 10:52:03 -0400
Subject: [PATCH v2 00/12] Remove mach-kirkwood
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Message-ID: <20140711145203.GD27706@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 11:36:20PM +0200, Andrew Lunn wrote:
> This patchset removes arch/arm/mach-kirkwood.  This SoCs is now
> supported in arch/arm/mach-mvebu using device tree.
> 
> V1 of this patchset also removed mach-dove. However it has been
> decided to leave it alone for a while to aid some developers get out
> of tree patches merged.
>                                                                          
> Change the dependencies for a number of drivers, either to use
> ARCH_MVEBU where the drivers are generic, or MACH_KIRKWOOD and where
> the drivers are specific to the SoC.
> 
> Once Jason Cooper has Acked these patches, we would prefer that
> individual subsystem maintainers take these patches through their own
> trees.

Please let me know when I can take the libata part.

Thanks.

-- 
tejun
