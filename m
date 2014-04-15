From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Apr 2014 16:27:00 +0200
Subject: [PATCH 4/7] net: rfkill: gpio: fix reversed clock enable state
In-Reply-To: <1397544101-18135-5-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-5-git-send-email-wens@csie.org>
Message-ID: <20140415142700.GF3207@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 02:41:38PM +0800, Chen-Yu Tsai wrote:
> rfkill-gpio has clk_enabled = blocked, which is true when rfkill
> blocks the device. This results in calling clock enable/disable at
> the wrong time. Reversing the value fixes this.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/2f947939/attachment.sig>
