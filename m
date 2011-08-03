From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Aug 2011 13:43:05 +0200
Subject: [PATCH v2] mfd:fix section mismatch warning in ab3550-core
In-Reply-To: <CACRpkdau6sv2T_TKx-GoVLU_AagaJDyiji11F8+wieVAOezkAw@mail.gmail.com>
References: <20110803083255.GJ9250@pengutronix.de>
	<1312361856-26127-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<CACRpkdau6sv2T_TKx-GoVLU_AagaJDyiji11F8+wieVAOezkAw@mail.gmail.com>
Message-ID: <20110803114305.GD31521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 03, 2011 at 12:19:06PM +0200, Linus Walleij wrote:
> On Wed, Aug 3, 2011 at 10:57 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wrote:
> 
Maybe add "This patch fixes:" before the actual warning?

> > WARNING: drivers/mfd/built-in.o(.data+0x9998): Section mismatch in reference from the variable ab3550_driver to the function .init.text:ab3550_probe()
> > The variable ab3550_driver references
> > the function __init ab3550_probe()
> > If the reference is valid then annotate the
> > variable with __init* or __refdata (see linux/init.h) or name the variable:
> > *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> >
> > Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
other than that, aol:

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
