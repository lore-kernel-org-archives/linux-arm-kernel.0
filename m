From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:39:24 +0200
Subject: [PATCH 2/6] ARM: dts: axp209: Disable ldo5 by default
In-Reply-To: <1463500571-28970-3-git-send-email-wens@csie.org>
References: <1463500571-28970-1-git-send-email-wens@csie.org>
 <1463500571-28970-3-git-send-email-wens@csie.org>
Message-ID: <20160525123924.GF9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 11:56:07PM +0800, Chen-Yu Tsai wrote:
> The output pin of LDO is also a GPIO pin, and the on/off settings of the
> regulator are actually pinmux settings.
> 
> Disable it by default so it doesn't conflict with GPIO usage.
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/67730757/attachment.sig>
