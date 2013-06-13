From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 09:26:38 +0900
Subject: [GIT PULL 6/6] s3c24xx driver
In-Reply-To: <20130612235158.GC9067@quad.lixom.net>
References: <51B791F6.4000004@samsung.com>
 <20130612235158.GC9067@quad.lixom.net>
Message-ID: <143901ce67cc$ab45c9f0$01d15dd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Wed, Jun 12, 2013 at 06:09:10AM +0900, Kukjin Kim wrote:
> > The following changes since commit
> 317ddd256b9c24b0d78fa8018f80f1e495481a10:
> >
> >   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
> >
> > are available in the git repository at:
> >
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/s3c24xx-driver-1
> >
> > for you to fetch changes up to ae7b6dccf6711e8d5815688f1572ab55bf5b3069:
> >
> >   Merge branch 'v3.11-next/driver-cpufreq' into
> > v3.11-next/s3c24xx-driver (2013-06-12 05:24:22 +0900)
> >
> > ----------------------------------------------------------------
> >
> > update driver for s3c24xx
> > - move cpufreq driver into drivers/
> > - add pinctrl-s3c24xx driver
> > - cleanup OF in gpio driver
> >
> > ----------------------------------------------------------------
> > Heiko Stuebner (1):
> >       pinctrl: Add pinctrl-s3c24xx driver
> >
> > Kukjin Kim (3):
> >       Merge branch 'v3.11-next/driver-gpio' into v3.11-next/s3c24xx-
> driver
> >       Merge branch 'v3.11-next/driver-pinctrl' into
> > v3.11-next/s3c24xx-driver
> >       Merge branch 'v3.11-next/driver-cpufreq' into
> > v3.11-next/s3c24xx-driver
> 
> Hi,
> 
Hi,

> No need to do a merge commit per patch, just do them on a single branch in
> the
> future, please.
> 
OK.

> Pulled.
> 
Thanks.

- Kukjin
