From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 17 Nov 2014 09:27:09 +0100
Subject: [PATCH 0/2] initial suport for Alphascale ASM9260
In-Reply-To: <1414401792-7445-1-git-send-email-linux@rempel-privat.de>
References: <1414401792-7445-1-git-send-email-linux@rempel-privat.de>
Message-ID: <5469B15D.8020502@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping

Am 27.10.2014 um 10:23 schrieb Oleksij Rempel:
> This is reduced patchset to provide initial support for Alpascale ASM9260.
> 
> 
> Oleksij Rempel (2):
>   ARM: add mach-asm9260
>   ARM: add lolevel debug support for asm9260
> 
>  arch/arm/Kconfig                 |  2 ++
>  arch/arm/Kconfig.debug           | 33 ++++++++++++++++++++++++++++++---
>  arch/arm/include/debug/asm9260.S | 31 +++++++++++++++++++++++++++++++
>  arch/arm/mach-asm9260/Kconfig    |  6 ++++++
>  4 files changed, 69 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/debug/asm9260.S
>  create mode 100644 arch/arm/mach-asm9260/Kconfig
> 

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141117/7b4353f3/attachment.sig>
