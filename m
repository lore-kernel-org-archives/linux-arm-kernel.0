From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Dec 2015 09:59:55 +0100
Subject: [PATCH resend 3/6] ARM: dts: sun4i: Add DRAM gates
In-Reply-To: <1449321407-4531-4-git-send-email-wens@csie.org>
References: <1449321407-4531-1-git-send-email-wens@csie.org>
 <1449321407-4531-4-git-send-email-wens@csie.org>
Message-ID: <20151207085955.GB27957@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 05, 2015 at 09:16:44PM +0800, Chen-Yu Tsai wrote:
> The DRAM gates controls direct memory access for some peripherals.
> These peripherals include the display pipeline, so add the required
> gates to the simplefb nodes as well.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151207/eb173f59/attachment.sig>
