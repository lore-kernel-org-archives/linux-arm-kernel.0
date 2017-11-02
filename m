From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 2 Nov 2017 17:28:08 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <20171102171018.GH9463@n2100.armlinux.org.uk>
References: <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021132170.21665@knanqh.ubzr>
 <nycvar.YSQ.7.76.1711021157560.21665@knanqh.ubzr>
 <SG2PR06MB116509D159F4E79D5A788DCE8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102171018.GH9463@n2100.armlinux.org.uk>
Message-ID: <SG2PR06MB116573DD79771C3EAA5CD3278A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 02, 2017, Russell King - ARM Linux wrote:
> This is very bad, and it's going to make it slower to get such
> patches into the kernel.

Well crap! All I wanted was my carriage returns back.

This is going to come back and bite me in the ass later when I try to 
submit some XIP code changes in head.S that I've been meaning to get to.


Chris
