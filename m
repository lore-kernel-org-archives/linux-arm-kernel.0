From: balbi@ti.com (Felipe Balbi)
Date: Wed, 27 Mar 2013 15:14:31 +0200
Subject: [PATCH V2 0/6] remove the clock name from pdata
In-Reply-To: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
References: <1364195217-1226-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20130327131431.GE4626@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 25, 2013 at 03:06:51AM -0400, Chao Xie wrote:
> The clock is defined by device, so the driver knows how many
> clocks needed by the device.
> The orignal way that passing the clock name by pdata is not correct.
> The following patches fix it.
> 
> V2->V1:
>    typo fix
>    rebased on latest usb-next
> 
> Chao Xie (6):
>   usb: gadget: mv_udc_core: remove unused clock
>   usb: otg: mv_otg: remove unused clock
>   usb: ehci: mv_ehci: remove unused clock
>   arm: mmp: remove clock from usb pdata for aspenite
>   arm: mmp: remove clock name from usb pdata for ttc
>   usb: mv_usb: remove clock name from pdata

how should this series be handled ?

If you want me to carry all patches, I need Acks from other maintainers
for ehci and arch/arm/ parts.

Until then, I'm dropping this from my TODO list.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130327/fdd5d4a4/attachment.sig>
