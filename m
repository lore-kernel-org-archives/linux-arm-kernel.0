From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 4 Jul 2016 10:02:04 -0700
Subject: [PATCH 0/2] mmc: sdhci-iproc: Use defines instead of magic numbers
In-Reply-To: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
References: <1467487394-28682-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <577A968C.3020107@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On 16-07-02 12:23 PM, Stefan Wahren wrote:
> Hi,
>
> this small patch series should make the sdhci-iproc platform data easier
> to read. Since i don't have the adequate hardware it's only compile tested.
>
> Stefan
>
> Stefan Wahren (2):
>    mmc: sdhci: add define for suspend/resume capability
>    mmc: sdhci-iproc: Use defines instead of magic numbers
>
>   drivers/mmc/host/sdhci-iproc.c |   13 +++++++++++--
>   drivers/mmc/host/sdhci.h       |    1 +
>   2 files changed, 12 insertions(+), 2 deletions(-)
>
Patch series looks fine.

Acked-by: Scott Branden <scott.branden@broadcom.com>
