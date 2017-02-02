From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Feb 2017 09:13:49 +0100
Subject: [PATCH] pinctrl: sunxi: Remove stray printk call in sun5i
 driver's probe function
In-Reply-To: <20170201160209.9261-1-wens@csie.org>
References: <20170201160209.9261-1-wens@csie.org>
Message-ID: <20170202081349.kqjho7ebjqdn35rh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 12:02:09AM +0800, Chen-Yu Tsai wrote:
> There is a stray printk call in the new sun5i pinctrl driver's probe
> function.
> 
> Remove it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170202/e55a7bd9/attachment.sig>
