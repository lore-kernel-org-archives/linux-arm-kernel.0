From: marex@denx.de (Marek Vasut)
Date: Fri, 5 Apr 2013 18:08:15 +0200
Subject: [PATCH] ARM: dts: imx23-olinuxino: Set the sdcard as non-removable
In-Reply-To: <CAAAP30FMObPdRg60eNov3FKRvycVrBxV-9DCu05Pb4Fx__H8Qw@mail.gmail.com>
References: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
 <201304051611.15003.marex@denx.de>
 <CAAAP30FMObPdRg60eNov3FKRvycVrBxV-9DCu05Pb4Fx__H8Qw@mail.gmail.com>
Message-ID: <201304051808.16034.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Pereira da Silva,

> On Fri, Apr 5, 2013 at 11:11 AM, Marek Vasut <marex@denx.de> wrote:
> > The CD line is working perfectly well on this board, so I don't get it.
> 
> In the schematics of this board, the SSP1_DETECT pin is connected to
> the green led. As I see, there is no way, the hardware can detect card
> removal. Am I missing something here?

You're right. Then the design is indeed defective. Sorry.

Best regards,
Marek Vasut
