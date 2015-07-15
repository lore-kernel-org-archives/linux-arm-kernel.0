From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 15 Jul 2015 16:37:11 +0530
Subject: [PATCH v5 0/7] phy-sun4i-usb: Add OTG and newer SoC support
In-Reply-To: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
References: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
Message-ID: <55A63EDF.60009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Saturday 13 June 2015 06:07 PM, Hans de Goede wrote:
> Hi Kishon,
> 
> Here is a patch series with all my oustanding phy-sun4i-usb changes pending
> for merging into 4.3.
> 
> This includes the 5th iteration of the OTG support addition, now with the
> extcon provider support addition split-out into a new patch and ported to
> the extcon API changes which are queued up for 4.2 from :
> 
> http://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-next-v4.2
> 
> which already merged in GKH's char-misc branch for 4.2, this means that
> this series now depends on those changes.
> 
> Other than that this is a resend of some of the other feature addition
> patches I recently send rebased on top of v5 of the OTG support.
> 
> Please merge this series for 4.3.

Fixed a couple of checkpatch warnings and merged this to linux-phy tree

WARNING: 'explictly' may be misspelled - perhaps 'explicitly'?
#113: FILE: drivers/phy/phy-sun4i-usb.c:164:
+		/* A33 needs us to set phyctl to 0 explictly */

ERROR: trailing whitespace
#556: FILE: drivers/phy/phy-sun4i-usb.c:461:
+^Istruct sun4i_usb_phy_data *data = $

Cheers
Kishon
