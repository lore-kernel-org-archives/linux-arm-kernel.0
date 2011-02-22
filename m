From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 22 Feb 2011 16:26:51 -0300
Subject: [PATCH 4/5] arm: mach-mx3: pcm043: add write-protect and
	card-detect for SD1
In-Reply-To: <1298379500-27590-5-git-send-email-w.sang@pengutronix.de>
References: <1298379500-27590-1-git-send-email-w.sang@pengutronix.de>
	<1298379500-27590-5-git-send-email-w.sang@pengutronix.de>
Message-ID: <AANLkTi=cDkuo9Q1Eqzno=_FKLN+0pNBCdvD=SqFsysVf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Feb 22, 2011 at 9:58 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
...
> ?#define AC97_GPIO_TXFS (1 * 32 + 31)
> ?#define AC97_GPIO_TXD ?(1 * 32 + 28)
> ?#define AC97_GPIO_RESET ? ? ? ?(1 * 32 + 0)
>
> +#define SD1_GPIO_WP ? ?(1 * 32 + 23)
> +#define SD1_GPIO_CD ? ?(1 * 32 + 24)

You could also do:

+#define SD1_GPIO_WP    IMX_GPIO_NR(2, 23)
+#define SD1_GPIO_CD     IMX_GPIO_NR(2, 24)

Regards,

Fabio Estevam
