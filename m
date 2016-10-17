From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Oct 2016 15:49:29 +0200
Subject: [PATCH 0/2] mmc: sdhci-iproc: Add byte register access support
In-Reply-To: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
References: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <CAPDyKFpsTNKCC3dTJUipRVhALh2=4YJ5k6Ofp9TUu0RjKO6FaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 October 2016 at 20:35, Scott Branden <scott.branden@broadcom.com> wrote:
> Add brcm,sdhci-iproc compat string and code for support of newer versions of
> sdhci-iproc controller that allow byte-wise register accesses.
>
> Scott Branden (2):
>   mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
>     document
>   mmc: sdhci-iproc: support standard byte register accesses
>
>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  1 +
>  drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> --
> 2.5.0
>

Thanks, applied for next!

Kind regards
Uffe
