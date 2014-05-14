From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 18:13:30 +0200
Subject: [PATCH] i2c: rcar: bail out on zero length transfers
In-Reply-To: <1399307781-23614-1-git-send-email-wsa@the-dreams.de>
References: <1399307781-23614-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20140514161330.GF12911@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 05, 2014 at 06:36:21PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This hardware does not support zero length transfers. Instead, the
> driver does one (random) byte transfers currently with undefined results
> for the slaves. We now bail out.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/832a9a59/attachment.sig>
