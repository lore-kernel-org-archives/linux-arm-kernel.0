From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Jun 2012 13:48:05 +0300
Subject: [RFC PATCH 0/3] usb: musb: add new phy driver
In-Reply-To: <1338388466-3565-1-git-send-email-kishon@ti.com>
References: <1338388466-3565-1-git-send-email-kishon@ti.com>
Message-ID: <20120612104803.GD10901@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2012 at 08:04:23PM +0530, Kishon Vijay Abraham I wrote:
> This series adds a new usb2 phy driver. The device for which is created
> by the ocp2scp driver. This also uses control module driver.
> 
> This series converts twl6030 as a comparator driver (previously it was
> also the phy driver) and makes use of omap-usb2 as the phy driver.
> 
> Instead of notification mechanism by power chip to omap glue to pass detection
> of any events, an export API has been added in omap glue. Both twl4030 and
> twl6030 will call to this API to pass any event. (twl6030 is used in omap4 and
> twl4030 is used in omap3).
> 
> This series depends on:
> *[RFC PATCH 00/11] OMAP System Control Module* patch series
> However System Control Module driver has only dt support, so wouldn't
> be able to test this patch series. However I'll adapt omap usb2 phy
> driver and musb driver for dt and send it asap to the list.
> 
> This series also depends on:
> *[PATCH v3 0/3] usb: multi-phy support* patch series
> *[RFC PATCH 0/5] omap: add ocp2scp as a misc driver* patch series
> 
> Compile tested only.

are we getting new version of this series ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120612/702f7f0b/attachment.sig>
