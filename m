From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 25 May 2014 21:02:11 +0200
Subject: [PATCH 10/22] clk: sunxi: Add support for PLL6 pre-divider on
 AHB1 clock
In-Reply-To: <1400831485-28576-11-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-11-git-send-email-wens@csie.org>
Message-ID: <20140525190211.GT10768@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 03:51:13PM +0800, Chen-Yu Tsai wrote:
> On the A31 and A23, the PLL6 input to the AHB1 clock has a 2 bit wide
> pre-divider. This was verified from the A23 user manual and A31/A23 SDK
> sources.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>


No, it should be part of the AHB1 clock code itself. It's internal
clock logic, isn't a clock per se, and as such, shouldn't be
reprensented as a separate clock.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140525/f60b6d8d/attachment.sig>
