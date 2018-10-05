From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 5 Oct 2018 14:24:41 +0200
Subject: [PATCH 09/12] i2c: zx2967: use core to detect 'no zero length'
 quirk
In-Reply-To: <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
 <20180723202617.15230-10-wsa+renesas@sang-engineering.com>
Message-ID: <20181005122441.GK5433@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 10:26:13PM +0200, Wolfram Sang wrote:
> And don't reimplement in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Ping.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/252e95a7/attachment.sig>
