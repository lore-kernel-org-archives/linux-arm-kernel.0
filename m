From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Nov 2010 18:07:18 -0200
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <20101124194439.GY4693@pengutronix.de>
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
Message-ID: <AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

2010/11/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Fabio,
>
> On Wed, Nov 24, 2010 at 05:29:31PM -0200, Fabio Estevam wrote:
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>> ---
>> This allows imx-for-2.6.38 tree to build again.
> The same patch is already in Sascha's imx-for-2.6.37 branch (and so in
> for-next, too). ?There are some more fixes in for-.37 so I'd use the
> for-next branch for now.

Thanks, I haven't noticed this. Will use for-next branch for now.

While at the dma topic: is anyone able to boot a kernel on MX51 with
IMX_SDMA=y?

I enabled early printk support, but no kernel messages appear after:
Uncompressing Linux... done, booting the kernel.

This also happens on the for-next branch.

Regards,

Fabio Estevam
