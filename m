From: balbi@ti.com (Felipe Balbi)
Date: Mon, 20 Jan 2014 17:39:41 -0600
Subject: [PATCH] mmc: omap_hsmmc: Add support for Erratum 2.1.1.128 in
 device tree boot
In-Reply-To: <1390260542-22213-1-git-send-email-nm@ti.com>
References: <1390260542-22213-1-git-send-email-nm@ti.com>
Message-ID: <20140120233941.GG6516@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 05:29:02PM -0600, Nishanth Menon wrote:
> When device is booted using devicetree, platforms impacted by
> Erratum 2.1.1.128 is not detected easily in the mmc driver. This erratum
> indicates that the module cannot do multi-block transfers.
> 
> Handle this by providing a boolean flag to indicate to driver that it is
> working on a hardware with mentioned limitation.

sure there's no way of reading the revision register to figure this one
out without having to add a new DT attribute ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/25bddc13/attachment.sig>
