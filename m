From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 23 Feb 2017 09:54:50 -0800
Subject: [PATCH v2 0/3] Add Northstar Plus support to PDC mailbox driver
In-Reply-To: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
References: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
Message-ID: <CAC3K-4oxR8+6=BcU5-c72JZmrSV2ezUueGK30Xt263Dg_4gmYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2017 at 6:49 AM, Steve Lin <steven.lin1@broadcom.com> wrote:
> Adds support for Broadcom Northstar+ to mailbox (PDC) driver.
>
> Patch 1/3: Driver code and Kconfig changes
> Patch 2/3: Device tree changes
> Patch 3/3: DT bindings documentation changes
>
> v2 addresses Jon Mason's suggestion about making the bindings doc change
> a separate patch.

FWIW, looks good to me.  Feel free to add my
Acked-by: Jon Mason <jon.mason@broadcom.com>
to the relevant pieces

> Steve Lin (3):
>   mailbox: bcm-pdc: Add Northstar Plus support to PDC driver
>   ARM: dts: NSP: Add mailbox (PDC) to NSP
>   dt-bindings: mailbox: Update doc with NSP PDC/mailbox support
>
>  .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |  6 ++-
>  arch/arm/boot/dts/bcm-nsp.dtsi                     |  9 ++++
>  drivers/mailbox/Kconfig                            |  9 ++--
>  drivers/mailbox/bcm-pdc-mailbox.c                  | 61 ++++++++++++++++------
>  4 files changed, 63 insertions(+), 22 deletions(-)
>
> --
> 2.1.0
>
