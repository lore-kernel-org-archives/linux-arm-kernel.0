From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 Aug 2016 14:15:45 +0200
Subject: [PATCH] clk: sunxi-ng: Fix wrong reset register offsets
In-Reply-To: <1472210653-32170-1-git-send-email-jorik@kippendief.biz>
References: <1472210653-32170-1-git-send-email-jorik@kippendief.biz>
Message-ID: <20160827121545.GT3165@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks a lot for your patch.

On Fri, Aug 26, 2016 at 01:24:13PM +0200, jorik at kippendief.biz wrote:
> From: Jorik Jonker <jorik@kippendief.biz>
> 
> The reset register offsets for UART*, I2C* and SCR were off by a few bytes.

You're missing your signed-off-by though. Could you resend it with it?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/09779014/attachment.sig>
