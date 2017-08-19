From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 19 Aug 2017 10:22:37 +0200
Subject: [PATCH v5 5/9] mtd: nand: tmio: Register partitions using the
 parsers
In-Reply-To: <1502743720-28672-6-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
 <1502743720-28672-6-git-send-email-andrea.adami@gmail.com>
Message-ID: <20170819082236.GA1460@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 10:48:36PM +0200, Andrea Adami wrote:
> With the introduction of sharpslpart partition parser we can now read the
> offsets from NAND: we specify the list of the parsers as platform data, with
> cmdlinepart and ofpart parsers first allowing to override the part. table
> written in NAND. This is done in the board files using this driver.
> 
> Use now these parsers.
> 
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/4bcb8406/attachment-0001.sig>
