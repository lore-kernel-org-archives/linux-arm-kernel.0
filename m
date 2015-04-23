From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 23 Apr 2015 10:31:42 -0400 (EDT)
Subject: [PATCHv3 0/4] add devm_of_phy_get_by_index and update platform
 drivers
In-Reply-To: <1429743853-10254-1-git-send-email-arun.ramamurthy@broadcom.com>
Message-ID: <Pine.LNX.4.44L0.1504231031170.1529-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Apr 2015, Arun Ramamurthy wrote:

> This patch set adds a new API to get phy by index when multiple 
> phys are present. This patch is based on discussion with Arnd Bergmann
> about dt bindings for multiple phys.
> 
> History:
> v1:
>     - Removed null pointers on Dmitry's suggestion
>     - Improved documentation in commit messages
>     - Exported new phy api
> v2:
>     - EHCI and OHCI platform Kconfigs select Generic Phy
>       to fix build errors in certain configs.
> v3:
>     - Made GENERIC_PHY an invisible option so 
>     that other configs can select it
>     - Added stubs for devm_of_phy_get_by_index
>     - Reformated code
> 
> Arun Ramamurthy (4):
>   phy: phy-core: Make GENERIC_PHY an invisible option
>   phy: core: Add devm_of_phy_get_by_index to phy-core
>   usb: ehci-platform: Use devm_of_phy_get_by_index
>   usb: ohci-platform: Use devm_of_phy_get_by_index

For patches 3 and 4:

Acked-by: Alan Stern <stern@rowland.harvard.edu>
