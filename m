From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 30 Apr 2014 09:01:17 +0200
Subject: [PATCH 1/3] arm: dts: imx6qdl, remove fsl,ssi-dma-events
In-Reply-To: <20140430063740.GD16727@dragon>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
 <1398694356-22511-2-git-send-email-mpa@pengutronix.de>
 <20140430063740.GD16727@dragon>
Message-ID: <20140430070117.GG15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:37:46PM +0800, Shawn Guo wrote:
> On Mon, Apr 28, 2014 at 04:12:34PM +0200, Markus Pargmann wrote:
> > All dtsi files where already moved to generic dma bindings. Remove the
> > old non-generic DMA properties.
> 
> Yea, since we're not required to boot old kernel with new DTB, we can
> drop it.  But can I ask you to clean it up globally for IMX dts files.

Yes sure, I already have those patches for all other dtsi files. I will
send them soon.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/ce4d70b7/attachment.sig>
