From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 19 Dec 2014 13:32:38 +0100
Subject: [PATCH 0/4] mmc: sunxi: General fixup (v2)
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Message-ID: <CAPDyKFoDQyrvZbCUYgvJFr-OVDkhm_EVc3TJ6Fuw1fD4ZQ6ABw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2014 at 15:10, David Lanzend?rfer
<david.lanzendoerfer@o2s.ch> wrote:
> Hello
> This patchset was inspired questions from ?? of Allwinner and incorporates as
> well suggestions from Hans related to spin locks.
> For example have not all attributes of the shared host object been protected
> by the spin lock, this has been changed.
> Also some register names and reset behavior have been fixed now.
> And a minor cleanup happened at the clock frequecy setting, since there has
> been a piece of left over code which has been there because it was in the Android
> driver and we just adapted it because we didn't have proper documentation about
> the timing of the module.
>
> Looking forward to your feedback
> Cheers David

Thanks! Queued for 3.20.

Kind regards
Uffe

>
> ---
>
> David Lanzend?rfer (3):
>       mmc: sunxi: Lock fix
>       mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
>       mmc: sunxi: Removing unused code
>
> Hans de Goede (1):
>       mmc: sunxi: Fix setup of last descriptor of dma transfer
>
>
>  drivers/mmc/host/sunxi-mmc.c |   29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> --
> Signature
