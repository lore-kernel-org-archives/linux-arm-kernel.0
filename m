From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Aug 2017 08:46:32 +0200
Subject: [PATCH] Revert "pinctrl: sunxi: Don't enforce bias disable (for
 now)"
In-Reply-To: <20170827125523.29208-1-plaes@plaes.org>
References: <20170827125523.29208-1-plaes@plaes.org>
Message-ID: <20170828064632.kcj4pleyuuulwjq7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1;4803;0c
On Sun, Aug 27, 2017 at 03:55:23PM +0300, Priit Laes wrote:
> This reverts commit 2154d94b40ea2a5de05245521371d0461bb0d669.
> 
> The original patch was intented to avoid some issues with the sunxi
> gpio rework and was supposed to be reverted after all the required
> DT bits had been merged around v4.10.
> 
> Signed-off-by: Priit Laes <plaes@plaes.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/fdcb06e3/attachment.sig>
