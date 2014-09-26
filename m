From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 26 Sep 2014 16:37:37 +0200
Subject: [PATCH v6 00/10] ARM: Berlin: Ethernet support
In-Reply-To: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140926143737.GA23559@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 04:33:46PM +0200, Antoine Tenart wrote:
> Hi all,
> 
> This series introduce support for the Ethernet controller on Berlin SoCs,
> using the existing pxa168 Ethernet driver. In order to do this, DT
> support is added to the driver alongside some other modifications and
> fixes.
> 
> This has been tested on a Berlin BG2Q DMP board.
> 
> Changes since v4:
> 	- removed the phy-addr property and added a phy subnode
> 	- added COMPILE_TEST for the pxa168_eth driver
> 
> Changes since v3:
>         - moved the addition of pxa168_eth_get_mac_address() to the patch
>           using it first
> 
> Changes since v2:
>         - reworked how the MAC address is configured
>         - made the clock anonymous
> 
> Changes since v1:
>         - removed custom Berlin Ethernet driver
>         - used the pxa168 Ethernet driver instead
>         - made modifications to the pxa168 driver (DT support, fixes)
> 

That's really the cover letter for the v5, not v6, I made a typo in the
subject...

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
