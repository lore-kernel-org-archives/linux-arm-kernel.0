From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 18:57:00 +0100
Subject: [PATCH] drm/sun4i: Fix error handling
In-Reply-To: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
References: <20161030084926.15303-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161102175700.qxqoljcjqse3nblr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2016 at 09:49:26AM +0100, Christophe JAILLET wrote:
> 'sun4i_layers_init()' returns an error pointer in case of error, not
> NULL. So test it with IS_ERR.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/a688de85/attachment.sig>
