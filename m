From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Jun 2014 18:01:34 +0200
Subject: [PATCH v3 2/4] ARM: sunxi: Add earlyprintk support using R_UART
 (sun6i/sun8i)
In-Reply-To: <1403275973-24259-3-git-send-email-wens@csie.org>
References: <1403275973-24259-1-git-send-email-wens@csie.org>
 <1403275973-24259-3-git-send-email-wens@csie.org>
Message-ID: <20140623160134.GI19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:52:51PM +0800, Chen-Yu Tsai wrote:
> sun6i/sun8i have a UART in the RTC block group, which can be used
> as an early console. This is most useful on sun8i as UART0 is muxed
> with MMC0, which is not available if we boot from MMC.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/4c33635f/attachment.sig>
