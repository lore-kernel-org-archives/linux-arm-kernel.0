From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 13 Nov 2015 20:03:02 +0000
Subject: [PATCH v2] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <CAMuHMdXsw8BBCY5-fxWLvF1vxh83DhhKGD113LTBu-8ZFV68gw@mail.gmail.com>
References: <1447251455-22731-1-git-send-email-chris.brandt@renesas.com>
 <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <CAMuHMdXsw8BBCY5-fxWLvF1vxh83DhhKGD113LTBu-8ZFV68gw@mail.gmail.com>
Message-ID: <HK2PR06MB056157A6457CA47C24BE30608A110@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

> If you create an arm-specific <asm/sections.h>, you also have to remove the line
>
>         generic-y += sections.h
>
> from arch/arm/include/asm/Kbuild.


That, I didn't know about. Thank you.

I'll submit a new patch on Monday.

Chris
