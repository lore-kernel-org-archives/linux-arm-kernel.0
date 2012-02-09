From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 09 Feb 2012 20:32:40 +0900
Subject: [PATCH 6/9] serial: samsung: Add support for EXYNOS5250
In-Reply-To: <CAH9JG2XE7nj1je9SYQ=zJKo0_P5Sx_ruZrDjtpnsL0Qtvzb+_Q@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-7-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2XE7nj1je9SYQ=zJKo0_P5Sx_ruZrDjtpnsL0Qtvzb+_Q@mail.gmail.com>
Message-ID: <069f01cce71e$8809f1d0$981dd570$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Cc: Thomas Abraham <thomas.abraham@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@suse.de>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> >  drivers/tty/serial/samsung.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index 3b07fb9..c55e5fb 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -1594,7 +1594,7 @@ static struct s3c24xx_serial_drv_data
> > s5pv210_serial_drv_data = {
> >  #endif
> >
> >  #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) ||
> \
> > -	defined(CONFIG_SOC_EXYNOS4412)
> > +	defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
> I think you can make it simple just use "#ifdef CONFIG_ARCH_EXYNOS "

I think, should be 'depends on SoC' not 'ARCH'

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
