From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 16 Aug 2014 11:55:53 -0500
Subject: [PATCH v3 0/7] net: cpsw: Support for am335x chip MACIDs
In-Reply-To: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140816165549.GC2858@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 16, 2014 at 05:18:28PM +0200, Markus Pargmann wrote:
> Hi,
> 
> This series adds support to the cpsw driver to read the MACIDs of the am335x
> chip and use them as fallback. These addresses are only used if there are no
> mac addresses in the devicetree, for example set by a bootloader.
> 
> In v3 I removed the previously seperate driver and included the changes into
> the main cpsw driver. I now check for a am33xx machine to not make this
> operation when running on davinci.
> 
> Patches 1-4 are some minor fixes for the cpsw driver.
> Patch 5 adds the readout support.
> Patches 6 and 7 are for am33xx.dtsi to actually enable this feature.

Minor comments, but in general, looks good to me:

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

Tests on real HW need to wait another 9 days...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/91783b38/attachment-0001.sig>
