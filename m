From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 7 Nov 2016 13:14:40 +0100
Subject: [PATCH v2 0/2] mmc: sdhci-iproc: Add byte register access support
In-Reply-To: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <CAPDyKFrWffNpwvXA7Yj2=t_9g-ikJnhpwqMpTp3+jCu1A9FRnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2016 at 17:37, Scott Branden <scott.branden@broadcom.com> wrote:
> Add brcm,sdhci-iproc compat string and code for support of newer versions of
> sdhci-iproc controller that allow byte-wise register accesses.
>
> Changes from v1:
> - added details to bindings documentation to clarify usage of brcm,sdhci-iproc
> compatibility string
>
> Scott Branden (2):
>   mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
>     document
>   mmc: sdhci-iproc: support standard byte register accesses
>
>  .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  9 ++++++
>  drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
>
> --
> 2.5.0
>

It seems I had already applied v1 of this series. I have dropped those
now, waiting to receive an ack from Rob first.

Kind regards
Uffe
