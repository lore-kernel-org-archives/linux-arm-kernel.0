From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 2 Feb 2010 15:33:01 +0100
Subject: [PATCH 21/25] imx: only define deprecated symbols conditionally
In-Reply-To: <alpine.LNX.2.00.1002021444050.15395@pobox.suse.cz>
References: <1262967452-24353-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-17-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-18-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-19-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-20-git-send-email-u.kleine-koenig@pengutronix.de>
	<1262967452-24353-21-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LNX.2.00.1002021444050.15395@pobox.suse.cz>
Message-ID: <20100202143301.GA20090@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jiri,

> > Define deprecated symbols in an #ifdef IMX_NEEDS_DEPRECATED_SYMBOLS ...
> > 
> > All files that still depend on the old definitions get
> > -DIMX_NEEDS_DEPRECATED_SYMBOLS passed to the compiler.
> > 
> > When all remaining users are fixed this allows including the soc
> > specific headers unconditionally.
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Eric Benard <eric@eukrea.com>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Alan Carvalho de Assis <acassis@gmail.com>
> > Cc: Daniel Mack <daniel@caiaq.de>
> > Cc: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> > Cc: Ilya Yanok <yanok@emcraft.com>
> > Cc: Holger Schurig <hs4233@mail.mn-solutions.de>
> > Cc: Jiri Kosina <jkosina@suse.cz>
> > Cc: Magnus Lilja <lilja.magnus@gmail.com>
> 
> What is the status of this patch please? Doesn't seem to be inluded in
> linux-next as of today.
Currently they sit in mxc-master[1] and wait for the merge window to
open.

Sascha, what do you think about adding your tree to next?

Best regards
Uwe

[1] git://git.pengutronix.de/git/imx/linux-2.6.git mxc-master

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
