From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 6 Jul 2016 18:21:44 +0200
Subject: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic numbers
In-Reply-To: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CAPDyKFrTRwwQr0UkjiRVp4_kt1Zv8=LKj0gfBSTzVHdxLTm_WA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 July 2016 at 21:23, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi,
>
> this small patch series should make the sdhci-iproc platform data easier
> to read. Since i don't have the adequate hardware it's only compile tested.
>
> Stefan
>
> Stefan Wahren (2):
>   mmc: sdhci: add define for suspend/resume capability
>   mmc: sdhci-iproc: Use defines instead of magic numbers
>
>  drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
>  drivers/mmc/host/sdhci.h       |    1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> --
> 1.7.9.5
>

Thanks, applied for next!

Kind regards
Uffe
