From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 9 Jul 2015 21:49:41 +0200
Subject: [PATCH 2/3] i2c: omap: abolish variable name confusion
In-Reply-To: <1435260890-32335-2-git-send-email-balbi@ti.com>
References: <1435260890-32335-1-git-send-email-balbi@ti.com>
 <1435260890-32335-2-git-send-email-balbi@ti.com>
Message-ID: <20150709194941.GH4744@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 02:34:49PM -0500, Felipe Balbi wrote:
> struct device pointers are usually called
> dev. Calling our struct omap_i2c_dev pointers
> also dev has caused enough confusion.
> 
> This is the result of a few simple sed rules
> to convert all struct omap_i2c_dev pointers
> to be called omap instead.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

I couldn't apply this one. On what was it based?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/a72b837d/attachment.sig>
