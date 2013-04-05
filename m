From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Fri, 5 Apr 2013 11:53:47 -0300
Subject: [PATCH] ARM: dts: imx23-olinuxino: Set the sdcard as non-removable
In-Reply-To: <201304051611.15003.marex@denx.de>
References: <1365135413-31493-1-git-send-email-aletes.xgr@gmail.com>
 <20130405091656.GD2667@S2101-09.ap.freescale.net>
 <201304051611.15003.marex@denx.de>
Message-ID: <CAAAP30FMObPdRg60eNov3FKRvycVrBxV-9DCu05Pb4Fx__H8Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 5, 2013 at 11:11 AM, Marek Vasut <marex@denx.de> wrote:
> The CD line is working perfectly well on this board, so I don't get it.

In the schematics of this board, the SSP1_DETECT pin is connected to
the green led. As I see, there is no way, the hardware can detect card
removal. Am I missing something here?
