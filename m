From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 2 Nov 2017 16:38:11 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1711021157560.21665@knanqh.ubzr>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021132170.21665@knanqh.ubzr>
 <nycvar.YSQ.7.76.1711021157560.21665@knanqh.ubzr>
Message-ID: <SG2PR06MB116509D159F4E79D5A788DCE8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 02, 2017 1, Nicolas Pitre wrote:
> OK.. I wanted to get to the bottom of this. The gas documentation says:
> 
> |9.4.2.1 Instruction Set Syntax
> |..............................
> |
> |Two slightly different syntaxes are supported for ARM and THUMB
> |instructions.  The default, `divided', uses the old style where ARM and
> |THUMB instructions had their own, separate syntaxes.  The new,
> |`unified' syntax, which can be selected via the `.syntax' directive,
> |and has the following main features:
> |
> |   * Immediate operands do not require a `#' prefix.

Well there you go!

We all have "gratuitously broken binutils"

;)

Chris
