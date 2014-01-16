From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jan 2014 10:25:31 +0100
Subject: [PATCH v2] pinctrl: sunxi: Honor GPIO output initial vaules
In-Reply-To: <1389854063-31016-1-git-send-email-wens@csie.org>
References: <1389854063-31016-1-git-send-email-wens@csie.org>
Message-ID: <20140116092531.GC31779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 02:34:23PM +0800, Chen-Yu Tsai wrote:
> Some GPIO users, such as fixed-regulator, request GPIO output with
> initial value of 1. This was ignored by sunxi driver.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Could you also send it to stable please?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140116/90959b8b/attachment.sig>
