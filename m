From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 3 Mar 2017 08:12:03 +0100
Subject: [PATCH] clk: sunxi-ng: tighten SoC deps on explicit AllWinner SoCs
In-Reply-To: <20170302174357.6246-1-pbrobinson@gmail.com>
References: <20170302174357.6246-1-pbrobinson@gmail.com>
Message-ID: <20170303071203.xbfu4t2jgwt3low3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 05:43:57PM +0000, Peter Robinson wrote:
> Tighten the depends on the various AllWinn SoCs so we don't
> inadvertantly get clock drivers when we're not wanting them
> like 32 bit SoC clocks for 64 bit configs. Ensure there's
> still test coverage though.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170303/a285001e/attachment-0001.sig>
