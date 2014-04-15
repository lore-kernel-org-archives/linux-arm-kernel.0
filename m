From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Apr 2014 16:26:26 +0200
Subject: [PATCH 3/7] net: rfkill: gpio: use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1397544101-18135-4-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-4-git-send-email-wens@csie.org>
Message-ID: <20140415142626.GE3207@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:41:37PM +0800, Chen-Yu Tsai wrote:
> rfkill-gpio calls clk_enable() without first calling clk_prepare(),
> resulting in a warning and no effect. Switch to clk_prepare_enable()
> and clk_disable_unprepare.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/2aa25c50/attachment.sig>
