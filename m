From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 5 Oct 2018 18:15:20 +0200
Subject: [RFC PATCH 2/4] i2c: core: remove level of indentation in
 i2c_transfer
In-Reply-To: <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
Message-ID: <20181005161520.wos3xiws6a6buzqz@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 06:14:21PM +0200, Wolfram Sang wrote:
> Using the common kernel pattern to bail out at the beginning if some
> conditions are not met, we can save a level of indentation. No
> functional change.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I think we can have this clean up already.

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181005/c127de5e/attachment.sig>
