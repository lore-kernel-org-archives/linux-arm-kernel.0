From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 17 Mar 2018 21:20:57 +0100
Subject: [PATCH] i2c: mv64xxx: Apply errata delay only in standard mode
In-Reply-To: <20180314170340.11951-1-gregory.clement@bootlin.com>
References: <20180314170340.11951-1-gregory.clement@bootlin.com>
Message-ID: <20180317202057.da5jyueigjjom5oz@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 06:03:40PM +0100, Gregory CLEMENT wrote:
> The errata FE-8471889 description has been updated. There is still a
> timing violation for repeated start. But the errata now states that it
> was only the case for the Standard mode (100 kHz), in Fast mode (400 kHz)
> there is no issue.
> 
> This patch limit the errata fix to the Standard mode.
> 
> It has been tesed successfully on the clearfog (Aramda 388 based board).
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180317/c08122bb/attachment.sig>
