From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu, 08 Jan 2015 10:01:39 +0100
Subject: [PATCH 0/2] suport for Alphascale ASM9260, part 3
In-Reply-To: <1417193454-31417-1-git-send-email-linux@rempel-privat.de>
References: <201411281509.19170.arnd@arndb.de>
 <1417193454-31417-1-git-send-email-linux@rempel-privat.de>
Message-ID: <54AE4773.5050302@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.11.2014 um 17:50 schrieb Oleksij Rempel:
> Oleksij Rempel (2):
>   ARM: irqchip: mxs: prepare driver for HW with different offsets
>   ARM: irqchip: mxs: add Alpascale ASM9260 support
> 
>  drivers/irqchip/Kconfig                    |   5 +
>  drivers/irqchip/Makefile                   |   2 +-
>  drivers/irqchip/alphascale_asm9260-icoll.h | 109 +++++++++++++++++++++
>  drivers/irqchip/irq-mxs.c                  | 150 ++++++++++++++++++++++++++---
>  4 files changed, 249 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/irqchip/alphascale_asm9260-icoll.h
> 

Any update here, should i resend this patches?

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/4f89be8e/attachment.sig>
