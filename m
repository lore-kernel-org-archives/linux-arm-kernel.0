From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Jan 2017 14:10:59 +0000
Subject: [PATCH v4 0/4] ARM: Add support for CONFIG_DEBUG_VIRTUAL
In-Reply-To: <20161226203842.19457-1-f.fainelli@gmail.com>
References: <20161209233628.6642-1-f.fainelli@gmail.com>
 <20161226203842.19457-1-f.fainelli@gmail.com>
Message-ID: <20170102141058.GG14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 26, 2016 at 12:38:38PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> This patch series builds on top of Laura's [PATCHv5 00/10] CONFIG_DEBUG_VIRTUAL
> for arm64 to add support for CONFIG_DEBUG_VIRTUAL for ARM.
> 
> This was tested on a Brahma B15 platform (ARMv7 + HIGHMEM + LPAE).
> 
> Note that the treewide changes would involve a huge CC list, which
> is why it has been purposely trimmed to just focusing on the DEBUG_VIRTUAL
> aspect.

Nothing stands out from a quick read-through of these patches, so for the
core ARM and SA11x0 bits:

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
