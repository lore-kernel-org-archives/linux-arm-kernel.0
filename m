From: balbi@ti.com (Felipe Balbi)
Date: Fri, 30 Nov 2012 16:10:55 +0200
Subject: [V2 PATCH 00/27] mv-usb fix and enhancement patches
In-Reply-To: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
References: <1354071986-28032-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20121130141012.GA17587@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 27, 2012 at 10:05:59PM -0500, Chao Xie wrote:
> The patches are divied into 4 parts
> 1. bug fixes
>   usb: gadget: mv_udc: use udc_start and udc_stop functions
>   usb: gadget: mv_udc: use devm_xxx for probe
>   usb: gadget: mv_udc: fix the clk APIs
>   usb: otg: mv_otg: use devm_xxx for probe
>   usb: otg: mv_otg: fix the clk APIs
>   usb: host: ehci-mv: fix clk APIs
>   usb: host: ehci-mv: remove unused variable
>   usb: gadget: mv_udc: fix the value of tranceiver
> Above patches are bug fixes.

The gadget and OTG parts I will start queueing once v3.8-rc1 is tagged,
please hang on.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121130/9dd8909e/attachment.sig>
