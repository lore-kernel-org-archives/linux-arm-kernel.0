From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 5 Oct 2018 18:14:54 +0200
Subject: [RFC PATCH 1/4] i2c: core: remove outdated DEBUG output
In-Reply-To: <20180920161423.13990-2-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-2-wsa+renesas@sang-engineering.com>
Message-ID: <20181005161454.usqywe3lbfqjqzb7@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 06:14:20PM +0200, Wolfram Sang wrote:
> The usefulness of this debug output is questionable. It covers only
> direct i2c_transfer calls and no SMBUS calls, neither direct nor
> emulated ones. And the latter one is largely used in the kernel, so a
> lot of stuff is missed. Also, we have a proper tracing mechanism for all
> these kinds of transfers in place for years now. Remove this old one.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I think we can have this clean up already.

Applied to for-next (with updated commit message), thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/8abbb817/attachment.sig>
