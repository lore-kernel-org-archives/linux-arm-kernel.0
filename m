From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 28 Oct 2014 13:04:57 +0100
Subject: [PATCH 0/2] initial suport for Alphascale ASM9260
In-Reply-To: <1414484787-6946-1-git-send-email-linux@rempel-privat.de>
References: <1414484787-6946-1-git-send-email-linux@rempel-privat.de>
Message-ID: <544F8669.2020807@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Against which branch should be this code committable? There are some
merge conflicts against arm-soc/for-next branch.

Am 28.10.2014 um 09:26 schrieb Oleksij Rempel:
> This is reduced patchset to provide initial support for Alpascale ASM9260.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/8baa596e/attachment.sig>
