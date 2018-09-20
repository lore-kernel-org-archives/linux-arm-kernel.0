From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Sep 2018 00:46:44 +0200
Subject: [RFC PATCH 2/4] i2c: core: remove level of indentation in
 i2c_transfer
In-Reply-To: <c7ee2547-1b3b-3e43-e933-234516031770@axentia.se>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
 <c7ee2547-1b3b-3e43-e933-234516031770@axentia.se>
Message-ID: <20180920224644.GA988@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 07:26:21PM +0200, Peter Rosin wrote:
> On 2018-09-20 18:14, Wolfram Sang wrote:
> > Using the common kernel pattern to bail out at the beginning if some
> > conditions are not met, we can save a level of indentation. No
> > functional change.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Yes please!

:)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/fc7e981a/attachment.sig>
