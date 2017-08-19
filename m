From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 19 Aug 2017 10:23:07 +0200
Subject: [PATCH v5 3/9] mfd: tmio: Add partition parsers platform data
In-Reply-To: <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-4-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170819082307.GB1460@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 10:48:34PM +0200, Andrea Adami wrote:
> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, with
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done in the board files using this driver.
> 
> Thus, we need to extend tmio_nand_data to consider the partition parsers.
> 
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/e99a1c1e/attachment.sig>
