From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 3 Jul 2016 22:04:23 +0200
Subject: [PATCH] phy: fix error handling
In-Reply-To: <1467525332-12963-1-git-send-email-christophe.jaillet@wanadoo.fr>
References: <1467525332-12963-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <20160703200423.GD4604@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 03, 2016 at 07:55:32AM +0200, Christophe JAILLET wrote:
> This is likely that checking 'phy->hsic_clk' instead of 'phy->clk' is
> expected here.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160703/e4f899e4/attachment.sig>
