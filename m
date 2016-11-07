From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 16:10:05 +0100
Subject: [PATCH] drm/sun4i: Propagate error to the caller
In-Reply-To: <20161107011957.GK3327@joana>
References: <20161104061352.12596-1-christophe.jaillet@wanadoo.fr>
 <20161107011957.GK3327@joana>
Message-ID: <20161107151005.7sobo4hn2hr6vfwv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 10:19:57AM +0900, Gustavo Padovan wrote:
> Hi Christophe,
> 
> 2016-11-04 Christophe JAILLET <christophe.jaillet@wanadoo.fr>:
> 
> > If 'sun4i_layers_init()' returns an error, propagate it instead of
> > returning -EINVAL unconditionally.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/310f8f7b/attachment-0001.sig>
