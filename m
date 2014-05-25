From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 20:48:08 +0200
Subject: [PATCH 03/22] clk: sunxi: add "pll6" to sun6i protected clock list
In-Reply-To: <1400831485-28576-4-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-4-git-send-email-wens@csie.org>
Message-ID: <20140525184808.GP10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:06PM +0800, Chen-Yu Tsai wrote:
> PLL6 is used by some important but undocumented module, most likely
> memory related, such as mbus or the actual memory controller. As we
> do not have a driver for that, add pll6 to the list of protected
> clocks, so that it won't be disabled and leave us with a non-responsive
> system.

What issue have you seen?

The system actually works pretty great on the A31.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/2cb99089/attachment-0001.sig>
