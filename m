From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 4 Nov 2016 08:48:40 +0100
Subject: [PATCH] drm/sun4i: Propagate error to the caller
In-Reply-To: <20161104061352.12596-1-christophe.jaillet@wanadoo.fr>
References: <20161104061352.12596-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161104074840.ybklkvgp5p4bgyvj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 07:13:52AM +0100, Christophe JAILLET wrote:
> If 'sun4i_layers_init()' returns an error, propagate it instead of
> returning -EINVAL unconditionally.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161104/873dafd5/attachment.sig>
