From: olof@lixom.net (Olof Johansson)
Date: Wed, 16 Jan 2013 16:22:37 -0800
Subject: [GIT PULL] Samsung fixes-3 for v3.8
In-Reply-To: <0c0301cdf447$109e7d50$31db77f0$@samsung.com>
References: <0c0301cdf447$109e7d50$31db77f0$@samsung.com>
Message-ID: <CAOesGMiRSUbsnP2cCC=Ur9zL1CG9HGT0AQZ_fMktL+QAUmiDzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 16, 2013 at 4:10 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi Arnd, Olof
>
> Here is Samsung fixes for v3.8, please pull from:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.8-samsung-fixes-3
>
> That branch fixes build warnings and error for S3C24XX/S3C64xx. And corrects
> dw-mshc properties on EXYNOS5 DT and fixes IRQ mapping on Cragganmore board.
>
> If any problems, please kindly let me know.
>
> Thanks.
>
> - Kukjin
>
> The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:
>
>   Linux 3.8-rc3 (2013-01-09 18:59:55 -0800)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.8-samsung-fixes-3
>
> for you to fetch changes up to cd9a8934a28d604ffb62e80ab08ba12fab128a1e:
>
>   ARM: S3C24XX: Make 'clk_msysclk' static (2013-01-16 15:53:48 -0800)
>
> ----------------------------------------------------------------
> Alim Akhtar (1):
>       ARM: dts: correct the dw-mshc timing properties as per binding
>
> Dimitris Papastamos (1):
>       ARM: S3C64XX: Fix up IRQ mapping for balblair on Cragganmore
>
> Sachin Kamat (2):
>       ARM: S3C24XX: Fix warnings in irq-s3c2416.c
>       ARM: S3C24XX: Make 'clk_msysclk' static

Those two are sparse fixes, please queue for 3.9 instead.


-Olof
