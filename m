From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 14 Sep 2010 14:19:52 +0200
Subject: [PATCH 1/1] ARM: pxa: fix NFS build issue
In-Reply-To: <AANLkTinmrATdicROXh7C_c-eH1Pr-r0cGCUfC8WR8ri4@mail.gmail.com>
References: <1284445197-17403-1-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTinmrATdicROXh7C_c-eH1Pr-r0cGCUfC8WR8ri4@mail.gmail.com>
Message-ID: <20100914121952.GA16960@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Tue, Sep 14, 2010 at 02:37:25PM +0800, Eric Miao wrote:
> On Tue, Sep 14, 2010 at 2:19 PM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
> > fs/built-in.o: In function `nfs_callback_authenticate':
> > compr_lzo.c:(.text+0x81380): undefined reference to `svc_gss_principal'
> > make: *** [.tmp_vmlinux1] Error 1
> >
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> 
> Cannot remember the exact link, but this should have been solved by
> adding the correct constraint to the Kconfig.
> 
> Uwe, do you have the link and what's the status of that patch being
> upstreamed?
The current status is here:

	http://thread.gmane.org/gmane.linux.kernel/1027380/focus=1033847

Changing the defconfig is a workaround only and IMHO the wrong way to
address the problem.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
