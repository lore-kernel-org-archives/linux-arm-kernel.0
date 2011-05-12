From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 12 May 2011 11:41:26 +0530
Subject: [PATCH 2/7] ASoC: Remove to support sound for S5PC100
In-Reply-To: <1305162674-25860-3-git-send-email-kgene.kim@samsung.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<1305162674-25860-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <BANLkTinqyFCwp3FCOyW=gVhotd1p8DnDyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 6:41 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> According to removing ARCH_S5PC100, we don't need to support
> sound for S5PC100.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?sound/soc/samsung/Kconfig | ? ?2 +-

You might also want to remove smdkc100 support from
 sound/soc/samsung/smdk_wm9713.c
 sound/soc/samsung/smdk_wm8580.c
And three other references to smdkc100 in sound/soc/samsung/Kconfig
