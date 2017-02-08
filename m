From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 08 Feb 2017 17:13:36 +0100
Subject: [PATCH -next] reset: uniphier: fix non static symbol warnings
In-Reply-To: <CAK7LNATyFHr0uXSADcVy7fnE+bs+go9fJ4KHrptH3MynubrRuA@mail.gmail.com>
References: <20170208155620.25055-1-weiyj.lk@gmail.com>
 <CAK7LNATyFHr0uXSADcVy7fnE+bs+go9fJ4KHrptH3MynubrRuA@mail.gmail.com>
Message-ID: <1486570416.2309.39.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-02-09 at 01:04 +0900, Masahiro Yamada wrote:
> 2017-02-09 0:56 GMT+09:00 Wei Yongjun <weiyj.lk@gmail.com>:
> > From: Wei Yongjun <weiyongjun1@huawei.com>
> >
> > Fixes the following sparse warnings:
> >
> > drivers/reset/reset-uniphier.c:68:34: warning:
> >  symbol 'uniphier_sld3_sys_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:73:34: warning:
> >  symbol 'uniphier_pro4_sys_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:81:34: warning:
> >  symbol 'uniphier_pro5_sys_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:89:34: warning:
> >  symbol 'uniphier_pxs2_sys_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:103:34: warning:
> >  symbol 'uniphier_ld11_sys_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:108:34: warning:
> >  symbol 'uniphier_ld20_sys_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:137:34: warning:
> >  symbol 'uniphier_sld3_mio_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:157:34: warning:
> >  symbol 'uniphier_pro5_sd_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:174:34: warning:
> >  symbol 'uniphier_ld4_peri_reset_data' was not declared. Should it be static?
> > drivers/reset/reset-uniphier.c:187:34: warning:
> >  symbol 'uniphier_pro4_peri_reset_data' was not declared. Should it be static?
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> 
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 
> Thanks!

Applied, thanks.

regards
Philipp
