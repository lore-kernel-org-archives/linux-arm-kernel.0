From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 5 Jul 2016 11:10:44 +0530
Subject: [PATCH v6 0/1] phy-sun4i-usb: Add support for peripheral-only mode
In-Reply-To: <1467667053-15122-1-git-send-email-hdegoede@redhat.com>
References: <1467667053-15122-1-git-send-email-hdegoede@redhat.com>
Message-ID: <577B485C.8010300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 05 July 2016 02:47 AM, Hans de Goede wrote:
> Hi Kishon,
> 
> Thanks for merging one of the 2 pending phy-sun4i-usb patches, I see
> that the other one actually has a conflict after merging in
> linux-phy/fixes. So here is a rebased version of it.
> 
> Note can you please make sure this gets into 4.8? I've a musb patch
> ("usb: musb: sunxi: Simplify dr_mode handling") heading into 4.8,
> which depends on the changes in this patch to keep host-only mode
> working (runtime dependency) and we do use host-only mode on a few
> boards.

sure.. but I think this patch can go only in the -rc cycle because of
of_usb_get_dr_mode_by_phy() API taking 2 arguments.

Thanks
Kishon
