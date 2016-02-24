From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Feb 2016 10:00:59 -0800
Subject: [PATCH 28/50] pinctrl: ssbi-mpp: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-29-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-29-git-send-email-ldewangan@nvidia.com>
Message-ID: <20160224180059.GA4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 06:45:53PM +0530, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration and clean
> the error path.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>

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
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/7c580f04/attachment.sig>
