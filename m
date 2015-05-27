From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 May 2015 16:36:30 +0200
Subject: [PATCH] ARM: dts: sun9i: Add device node for watchdog
In-Reply-To: <1432659256-13278-1-git-send-email-wens@csie.org>
References: <1432659256-13278-1-git-send-email-wens@csie.org>
Message-ID: <20150527143630.GS8557@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 12:54:16AM +0800, Chen-Yu Tsai wrote:
> On A80 there are 2 watchdogs, one in the main block, and one in the
> R (special) block. We do not have information on the R block watchdog,
> other than the register layout is the same, and the interrupt number.
> Both are able to reset the whole system.
> 
> Add the main watchdog, in case the R block is used for special purposes
> like running an RTOS.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150527/1cb78a55/attachment-0001.sig>
