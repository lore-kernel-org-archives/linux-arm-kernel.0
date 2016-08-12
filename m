From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 12 Aug 2016 14:06:46 +0530
Subject: [PATCH resend 0/1] phy-sun4i-usb: Add support for peripheral-only
 mode
In-Reply-To: <1470686139-19893-1-git-send-email-hdegoede@redhat.com>
References: <1470686139-19893-1-git-send-email-hdegoede@redhat.com>
Message-ID: <57AD8A9E.5000106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 09 August 2016 01:25 AM, Hans de Goede wrote:
> Hi Kishon,
> 
> As discussed before, here is a resend now that rc1 is out (and includes
> the new of_usb_get_dr_mode_by_phy helper this patch needs).
> 
> Please merge this for 4.9-rcX some of the musb-sunxi glue changes
> already merged have a runtime dependency on this patch, without
> this patch boards using the musb controller in host-only mode
> will break.

merged, thanks.

-Kishon
> 
> Thanks & Regards,
> 
> Hans
> 
> 
