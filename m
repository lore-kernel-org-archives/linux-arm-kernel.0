From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Jul 2014 13:46:14 +0200
Subject: [PATCH 1/2] pinctrl: sunxi: use gpiolib API to mark a GPIO used
 as an IRQ
In-Reply-To: <1405358677-23657-2-git-send-email-wens@csie.org>
References: <1405358677-23657-1-git-send-email-wens@csie.org>
 <1405358677-23657-2-git-send-email-wens@csie.org>
Message-ID: <20140724114614.GU20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

Sorry for the belated reply.

On Tue, Jul 15, 2014 at 01:24:36AM +0800, Chen-Yu Tsai wrote:
> When an IRQ is started on a GPIO line, mark this GPIO as IRQ in
> the gpiolib so we can keep track of the usage centrally.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

It looks fine:
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/c63c7f89/attachment.sig>
