From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 9 Apr 2014 16:51:33 +0200
Subject: [PATCH 06/15] clk: sunxi: add A31 APB0 gates compatible string
 to the documentation
In-Reply-To: <1397051478-4113-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397051478-4113-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140409145133.GF28585@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 09, 2014 at 03:51:09PM +0200, Boris BREZILLON wrote:
> Add the new "allwinner,sun6i-a31-apb0-gates-clk" compatible string to the
> sunxi clock documentation.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

I'd probably merge this with the previous patch.

There's not really any new bindings introduced here, so I guess you
don't really have to make it two commits.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140409/38ebf16f/attachment.sig>
