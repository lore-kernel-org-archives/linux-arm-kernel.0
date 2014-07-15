From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Jul 2014 08:54:30 +0200
Subject: [PATCH v4 6/6] ARM: sun8i: Add PRCM clock and reset controller
 nodes to the DTSI
In-Reply-To: <1404892479-12222-7-git-send-email-wens@csie.org>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-7-git-send-email-wens@csie.org>
Message-ID: <20140715065430.GD3745@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 03:54:39PM +0800, Chen-Yu Tsai wrote:
> With sun8i PRCM support available, we can add the PRCM clock and
> reset controller nodes to the DTSI. Also update R_UART's clock
> phandle and add it's reset control phandle.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/e31ae3db/attachment-0001.sig>
