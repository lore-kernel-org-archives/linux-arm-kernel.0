From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Sep 2015 09:19:46 +0200
Subject: [PATCH 2/3] PCI: Add quirks for devices found on Cavium ThunderX
 SoCs.
In-Reply-To: <1442529694-1792-3-git-send-email-ddaney.cavm@gmail.com>
References: <1442529694-1792-1-git-send-email-ddaney.cavm@gmail.com>
 <1442529694-1792-3-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <3066583.BWDZlYWxXU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 September 2015 15:41:33 David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The on-chip devices all have fixed bars.  So, fix them up.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> 

You should be able to just mark the BARs as fixed in DT and not need
this hack. If that doesn't work with current kernels, it would be
better to fix the kernel to respect the flags.

	Arnd
