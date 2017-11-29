From: lukma@denx.de (Lukasz Majewski)
Date: Wed, 29 Nov 2017 10:45:45 +0100
Subject: [PATCH v2 0/6] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171121143204.1839-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de>
Message-ID: <20171129104545.0c03e766@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,

> This patch series adds support for Liebherr's BK3 board, being
> a derivative of TS72XX design.
> 
> This patchset consists of following patches:
> 
> - ts72xx.[c|h] cosmetic cleanup/improvement
> - Rewrite ts72xx.c to be reusable by bk3
> - The Liebherr's BK3 board has been added with re-using code of
>   ts72xx.c
> 
> This series applies on top of v4.14

Do you have any comments regarding this patch series?

> 
> Lukasz Majewski (6):
>   ARM: ep93xx: ts72xx: Use DEFINE_RES_MEM macros where applicable
>   ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
>   ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash() to accept
>     parameters
>   ARM: ep93xx: ts72xx: Rewrite map IO code to be reusable
>   ARM: ep93xx: ts72xx: cosmetic: Add some description to ts72xx code
>   ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative
> 
>  arch/arm/mach-ep93xx/Kconfig  |   7 +++
>  arch/arm/mach-ep93xx/ts72xx.c | 137
> +++++++++++++++++++++++++++++++-----------
> arch/arm/mach-ep93xx/ts72xx.h |   9 +++ arch/arm/tools/mach-types
> |   1 + 4 files changed, 120 insertions(+), 34 deletions(-)
> 



Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171129/72d37d17/attachment.sig>
