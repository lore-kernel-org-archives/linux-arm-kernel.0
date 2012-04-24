From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 10:56:43 +0200
Subject: [PATCH v2 3/3] ARM: imx6q: switch to use pinctrl driver
In-Reply-To: <1334933916-12971-3-git-send-email-b29396@freescale.com>
References: <1334933916-12971-1-git-send-email-b29396@freescale.com>
 <1334933916-12971-3-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdbbdkhN-hVF6vP4j6bP-Nsdft5UjjpAVhcKn6KSpEbcuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 4:58 PM, Dong Aisheng <b29396@freescale.com> wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>
>
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
>
> ---
> This is not a formal patch and is only used for test
> since before the pinctrl core handle dummy state is in,
> enable pinctrl in driver will break other platforms.
>
> ChangeLog v1->v2:
> * using updated binding
> ---
> ?arch/arm/boot/dts/imx6q-arm2.dts ? | ? ?2 ++
> ?arch/arm/boot/dts/imx6q.dtsi ? ? ? | ? 17 +++++++++++++++++
> ?arch/arm/mach-imx/Kconfig ? ? ? ? ?| ? ?2 ++
> ?drivers/mmc/host/sdhci-esdhc-imx.c | ? 12 ++++++++++++
> ?4 files changed, 33 insertions(+), 0 deletions(-)

Since this touches the MMC driver I'd like an ACK from the
maintainer, but no maintainer is set for this subdriver, still
it feels like Sascha and/or Wolfram should be involved.

Yours,
Linus Walleij
