From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Jan 2014 23:17:40 +0100
Subject: [PATCH v2 3/8] clk: sunxi: get divs parent clock name from
 parent factor clock
In-Reply-To: <1388987892-23733-4-git-send-email-wens@csie.org>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-4-git-send-email-wens@csie.org>
Message-ID: <20140107221740.GG3103@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 01:58:07PM +0800, Chen-Yu Tsai wrote:
> Divs clocks consist of a parent factor clock with multiple outputs,
> and seperate clocks for each output. Get the name of the parent
> clock from the parent factor clock, instead of the DT node name.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/fffe0c71/attachment.sig>
