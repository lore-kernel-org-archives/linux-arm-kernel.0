From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 16:53:59 +0900
Subject: [PATCH 2/7] ASoC: Remove to support sound for S5PC100
In-Reply-To: <BANLkTinqyFCwp3FCOyW=gVhotd1p8DnDyw@mail.gmail.com>
References: <1305162674-25860-1-git-send-email-kgene.kim@samsung.com>
	<1305162674-25860-3-git-send-email-kgene.kim@samsung.com>
	<BANLkTinqyFCwp3FCOyW=gVhotd1p8DnDyw@mail.gmail.com>
Message-ID: <03fa01cc1079$c2583670$4708a350$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar wrote:
> 
> On Thu, May 12, 2011 at 6:41 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > According to removing ARCH_S5PC100, we don't need to support
> > sound for S5PC100.
> >
> > Cc: Jassi Brar <jassisinghbrar@gmail.com>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  sound/soc/samsung/Kconfig |    2 +-
> 
Hi Jassi,

Oops...Yeah, you're right.
Thanks for your pointing out :)

Will update soon.

> You might also want to remove smdkc100 support from
>  sound/soc/samsung/smdk_wm9713.c
>  sound/soc/samsung/smdk_wm8580.c
> And three other references to smdkc100 in sound/soc/samsung/Kconfig

I found something for smdkc100 in smdk_wm8580.c but I'm not sure which should be removed in smdk_wm9713.c.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
