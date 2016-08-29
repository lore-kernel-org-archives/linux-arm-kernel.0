From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Aug 2016 08:39:16 +0200
Subject: [PATCH] clk: sunxi-ng: Fix wrong reset register offsets
In-Reply-To: <1472324673-11233-1-git-send-email-jorik@kippendief.biz>
References: <20160827121545.GT3165@lukather>
 <1472324673-11233-1-git-send-email-jorik@kippendief.biz>
Message-ID: <20160829063916.GA7612@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 27, 2016 at 09:04:33PM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> The reset register offsets for UART*, I2C* and SCR were off by a few bytes.
> 
> Signed-off-by: Jorik Jonker <jorik@kippendief.biz>

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160829/980071bc/attachment-0001.sig>
