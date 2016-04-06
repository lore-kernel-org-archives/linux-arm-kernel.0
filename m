From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 6 Apr 2016 10:32:54 +0200
Subject: [PATCH v4 0/3] davinci_mmc fixes
In-Reply-To: <1459877512-25479-1-git-send-email-david@lechnology.com>
References: <1459877512-25479-1-git-send-email-david@lechnology.com>
Message-ID: <CAPDyKFrAWu7hYY_Jwpm5qWz=b=cvDrFwMFedhZHRWCwP-EtJsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 April 2016 at 19:31, David Lechner <david@lechnology.com> wrote:
> This fixes a compiler warning in the "fix unwinding in probe" patch where ret
> was used uninitalized.
>
> David Lechner (3):
>   mmc: davinci: fix unwinding in probe
>   mmc: davinci: prepare clock
>   ARM: davinci: remove mmc dma resources
>
>  arch/arm/mach-davinci/devices-da8xx.c |  20 -------
>  arch/arm/mach-davinci/devices.c       |  16 ------
>  drivers/mmc/host/davinci_mmc.c        | 100 ++++++++++++++--------------------
>  3 files changed, 40 insertions(+), 96 deletions(-)
>
> --
> 1.9.1
>

Thanks, applied for next!

Kind regards
Uffe
