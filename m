From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Nov 2012 09:03:38 +0000
Subject: [GIT PULL] ST-Ericsson Device Tree patches
In-Reply-To: <201211261749.17958.arnd@arndb.de>
References: <20121120162836.GE28265@gmail.com>
 <20121126160755.GD6824@gmail.com>
 <201211261749.17958.arnd@arndb.de>
Message-ID: <20121127090338.GD7897@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2012, Arnd Bergmann wrote:

> On Monday 26 November 2012, Lee Jones wrote:
> > Arnd, Olof,
> > 
> > The previous pull request had some duplicate patches in, which have now been
> > removed. Please remove the previous branch and replace it with this one.
> > 
> 
> Hi Lee,
> 
> There are quite a number of patches that got merged into next/dt after your
> series. If there are just a few duplicate patches, I would prefer to leave
> it there rather than replace and redo the merges on top, which has the
> potential of creating other history confusion if someone based another branch
> on top of next/dt without telling us.

I'll give you the information and leave the decision up to you.

> If you still think we should replace that branch, please be more specific
> about what patches are affected.

/* Patches that appear twice */
$ git log --format=%s v3.7-rc3..arm-soc/ux500/dt | sort | uniq -c | sort -r
 2 ARM: ux500: Move regulator-name properties out to board DTS files
 2 ARM: ux500: Enable SDI4 port on the u9540 when booting with Device Tree
 2 ARM: ux500: Enable all MMC devices on the u9540 when booting with DT
 2 ARM: ux500: Add UART support to the u9540 Device Tree
 2 ARM: ux500: Add skeleton DTS file for the u9540
 2 ARM: ux500: Add SDI (MMC) support to the HREF Device Tree
<snip>

Instead of cocking up your tree, would you like me to send another pull-
request containing reverts for the second appearance of these patches?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
