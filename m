From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 13 Sep 2017 20:42:41 +0200
Subject: [PATCH 0/2] clk: sunxi-ng: Add several flags to H3 CCU
In-Reply-To: <20170910124006.60250-1-icenowy@aosc.io>
References: <20170910124006.60250-1-icenowy@aosc.io>
Message-ID: <20170913184241.b3dypwygczkfxrvx@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 10, 2017 at 08:40:04PM +0800, Icenowy Zheng wrote:
> The H3 CCU is the earliest driver that uses sunxi-ng clk framework, and
> some problems show when doing further development.
> 
> This patchset fixes some issues by add several clock flags.
> 
> The first patch solves the problem that setting some PLL before ungating
> them will trigger timeout for waiting for lock by adds CLK_SET_RATE_UNGATE
> flag.
> 
> The second patch solves the problem that H3 GPU clock is not really tweaked
> by add CLK_SET_RATE_PARENT flag to it.

Queued both for 4.15, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170913/338f42ed/attachment.sig>
