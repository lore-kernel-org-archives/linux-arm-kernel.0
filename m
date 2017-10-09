From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 9 Oct 2017 09:16:18 +0200
Subject: [PATCH] clk: sunxi-ng: a83t: Fix invalid csi-mclk mux offset
In-Reply-To: <20171005023314.21663-1-megous@megous.com>
References: <20171005023314.21663-1-megous@megous.com>
Message-ID: <20171009071618.liicj4whwamozvku@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 02:33:14AM +0000, megous at megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
> 
> Datasheet specified that parent MUX settings are at bits [10:8],
> but current implementation specifies incorrect offset at [10:12].
> Fix this.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171009/b11ba67b/attachment.sig>
