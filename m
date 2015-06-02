From: balbi@ti.com (Felipe Balbi)
Date: Tue, 2 Jun 2015 10:02:20 -0500
Subject: [PATCH v4 2/2] musb: Add support for the Allwinner sunxi musb
 controller
In-Reply-To: <1433088626-8858-3-git-send-email-hdegoede@redhat.com>
References: <1433088626-8858-1-git-send-email-hdegoede@redhat.com>
 <1433088626-8858-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150602150220.GB9623@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 31, 2015 at 06:10:26PM +0200, Hans de Goede wrote:
> This is based on initial code to get the Allwinner sunxi musb controller
> supported by Chen-Yu Tsai and Roman Byshko.
> 
> This adds support for the Allwinner sunxi musb controller in both host only
> and otg mode. Peripheral only mode is not supported, as no boards use that.
> 
> This has been tested on a cubietruck (A20 SoC) and an UTOO P66 tablet
> (A13 SoC) with a variety of devices in host mode and with the g_serial gadget
> driver in peripheral mode, plugging otg / host cables in/out a lot of times
> in all possible imaginable plug orders.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

this looks good, I'd say it's ready for v4.3

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/30db435a/attachment-0001.sig>
