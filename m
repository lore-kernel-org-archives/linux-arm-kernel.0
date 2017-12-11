From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 11 Dec 2017 23:43:10 +0000
Subject: [PATCH v5 0/4] ARM: ep93xx: ts72xx: Add support for BK3 board
In-Reply-To: <20171211233625.5689-1-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171211233625.5689-1-lukma@denx.de>
Message-ID: <SN1PR0101MB1565FCD7EA5B6FB842F5FC7ED0370@SN1PR0101MB1565.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 11, 2017 4:36 PM, Lukasz Majewski wrote:
> This patch series adds support for Liebherr's BK3 board, being a derivative of TS72XX design.
>
> This patchset consists of following patches:
>
> - ts72xx.[c|h] cosmetic cleanup/improvement
> - Rewrite ts72xx.c to be reusable by bk3
> - The Liebherr's BK3 board has been added with re-using code of
>   ts72xx.c (detalied list of changes can be found in patch 4/4)
>
> This series applies on top of linux-next/master (next-20171211)
>
> Lukasz Majewski (4):
>   ARM: ep93xx: ts72xx: Provide include guards for ts72xx.h file
>   ARM: ep93xx: ts72xx: Rewrite ts72xx_register_flash() to accept
>     parameters
>   ARM: ep93xx: ts72xx: cosmetic: Add some description to ts72xx code
>   ARM: ep93xx: ts72xx: Add support for BK3 board - ts72xx derivative
>
>  MAINTAINERS                   |   6 ++
>  arch/arm/mach-ep93xx/Kconfig  |   7 ++
>  arch/arm/mach-ep93xx/ts72xx.c | 165 +++++++++++++++++++++++++++++++++++++++---
>  arch/arm/mach-ep93xx/ts72xx.h |   9 +++
>  arch/arm/tools/mach-types     |   1 +
>  5 files changed, 176 insertions(+), 12 deletions(-)

Looks good. Thanks!

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
