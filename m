From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 17 Jan 2012 16:23:01 +0900
Subject: [GIT PULL] Samsung devel for v3.3
In-Reply-To: <CAOesGMiU+-wfxsfha7GTO3s7dHysP65gcrbJsLWhBpZNT9O+UQ@mail.gmail.com>
References: <018801ccca70$25f01260$71d03720$%kim@samsung.com>
 <CAOesGMhLE3wxM=F9OkHT-bQpsVp8Uc6eE8Uk+WN9pLuz5BRLBw@mail.gmail.com>
 <20120108204953.GA20043@sirena.org.uk>
 <CAOesGMjn5uQEWbxrJryC+jOf=3SYbAnPY4A71NUZKFBi=a0QjA@mail.gmail.com>
 <20120109082640.GI22134@opensource.wolfsonmicro.com>
 <CAOesGMiU+-wfxsfha7GTO3s7dHysP65gcrbJsLWhBpZNT9O+UQ@mail.gmail.com>
Message-ID: <001f01ccd4e8$d8456730$88d03590$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Hi,
> 
Hi Olof,

> On Mon, Jan 9, 2012 at 12:26 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Sun, Jan 08, 2012 at 05:21:02PM -0800, Olof Johansson wrote:
> >
> >> Mark, Kukjin, can either of you split out the fixes in a separate
> branch?
> >
> > Here's some of them, there were a few others I'm aware of that depended
> > on feature updates. ?Ideally we'd actually get all the changes that have
> > been in -next in.
> >
> > The following changes since commit
> 5f0a6e2d503896062f641639dacfe5055c2f593b:
> >
> > ?Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)
> >
> > are available in the git repository at:
> > ?git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git
> fixes/samsung
> >
> > Mark Brown (5):
> > ? ? ?ARM: SAMSUNG: Fix GPIO space reservation for S3C64xx platforms
> > ? ? ?ARM: S3C64XX: Correct reservation of GPIOs for CPU module on
> Cragganmore
> 
> The above two don't seem to have been in the branch that was sent by
> Kukjin, it had:
> 
>       ARM: EXYNOS: Invert VCLK polarity for framebuffer on ORIGEN
>       ARM: S3C64XX: Fix interrupt configuration for PCA935x on Cragganmore
>       ARM: S3C64XX: Fix the memory mapped GPIOs on Cragganmore
>       ARM: S3C64XX: Remove hsmmc1 from Cragganmore
>       ARM: S3C64XX: Remove unconditional power domain disables
>       ARM: SAMSUNG: Declare struct platform_device in plat/s3c64xx-spi.h
>       ARM: SAMSUNG: dma-ops.h needs mach/dma.h
>       ARM: SAMSUNG: Guard against multiple inclusion of plat/dma.h
> 
> I've pulled the branch from him.
> 
No, please drop it because above you said are in mainline now.

- commit 4ff13995("ARM: SAMSUNG: Fix GPIO space reservation for S3C64xx
platforms") 
- commit aaed44e1("ARM: S3C64XX: Correct reservation of GPIOs for CPU module
on Cragganmore")

Seems to be merged via arm-soc/next/boards and there was some
mis-communications.
(Refer to the commit 8df97495 ("Merge branch 'samsung/board' into
next/boards"))

Sorry for bothering.

> Kukjin, please consider picking up the missing two patches above and
> send another pull request with those and any other needed fixes.
> 
As I said, please ignore next-samsung-devel-samsung and Mark's
fixes/samsung.
I think, you can go ahead with my previous pull request, samsung-fixes.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
