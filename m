From: gustavo@padovan.org (Gustavo Padovan)
Date: Mon, 7 Nov 2016 10:19:57 +0900
Subject: [PATCH] drm/sun4i: Propagate error to the caller
In-Reply-To: <20161104061352.12596-1-christophe.jaillet@wanadoo.fr>
References: <20161104061352.12596-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20161107011957.GK3327@joana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christophe,

2016-11-04 Christophe JAILLET <christophe.jaillet@wanadoo.fr>:

> If 'sun4i_layers_init()' returns an error, propagate it instead of
> returning -EINVAL unconditionally.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Gustavo
