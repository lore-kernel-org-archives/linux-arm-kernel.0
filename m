From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Tue, 24 Apr 2012 17:15:04 +0800
Subject: [PATCH v2 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <CACRpkdbbdkhN-hVF6vP4j6bP-Nsdft5UjjpAVhcKn6KSpEbcuQ@mail.gmail.com>
References: <1334933916-12971-1-git-send-email-b29396@freescale.com>
 <1334933916-12971-3-git-send-email-b29396@freescale.com>
 <CACRpkdbbdkhN-hVF6vP4j6bP-Nsdft5UjjpAVhcKn6KSpEbcuQ@mail.gmail.com>
Message-ID: <20120424091504.GC32166@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Apr 24, 2012 at 10:56:43AM +0200, Linus Walleij wrote:
> On Fri, Apr 20, 2012 at 4:58 PM, Dong Aisheng <b29396@freescale.com> wrote:
> 
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> >
> > ---
> > This is not a formal patch and is only used for test
> > since before the pinctrl core handle dummy state is in,
> > enable pinctrl in driver will break other platforms.
> >
> > ChangeLog v1->v2:
> > * using updated binding
> > ---
> > ?arch/arm/boot/dts/imx6q-arm2.dts ? | ? ?2 ++
> > ?arch/arm/boot/dts/imx6q.dtsi ? ? ? | ? 17 +++++++++++++++++
> > ?arch/arm/mach-imx/Kconfig ? ? ? ? ?| ? ?2 ++
> > ?drivers/mmc/host/sdhci-esdhc-imx.c | ? 12 ++++++++++++
> > ?4 files changed, 33 insertions(+), 0 deletions(-)
> 
> Since this touches the MMC driver I'd like an ACK from the
> maintainer, but no maintainer is set for this subdriver, still
> it feels like Sascha and/or Wolfram should be involved.
> 
This is for test.
Before the pinctrl dummy state patch got in first, we can not get
it in since it will break other platforms not support pinctrl to
use this driver.
I will send a formal patch after dummy state patch is in.

Thanks for the review.

Regards
Dong Aisheng
