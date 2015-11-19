From: marex@denx.de (Marek Vasut)
Date: Thu, 19 Nov 2015 17:00:09 +0100
Subject: [PATCH] ARM: socfpga: Add support for DENX MCV SoM and MCVEVK
 baseboard
In-Reply-To: <CADhT+weX7o5=pb0iyxPUAdjQ9DJi=qeAgFhSPojXRDYY3twbRg@mail.gmail.com>
References: <1446420549-5572-1-git-send-email-marex@denx.de>
 <201511181050.30515.marex@denx.de>
 <CADhT+weX7o5=pb0iyxPUAdjQ9DJi=qeAgFhSPojXRDYY3twbRg@mail.gmail.com>
Message-ID: <201511191700.09747.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 19, 2015 at 04:57:01 PM, Dinh Nguyen wrote:
> On Wed, Nov 18, 2015 at 3:50 AM, Marek Vasut <marex@denx.de> wrote:
> > On Monday, November 02, 2015 at 12:29:09 AM, Marek Vasut wrote:
> >> Add support for the DENX MCV SoM and MCVEVK baseboard. The SoM contains
> >> eMMC, DRAM, Altera Cyclone V SoC. The baseboard contains CAN ports, UART
> >> ports, STMPE811 touchscreen controller, USB OTG port, ethernet port and
> >> a lot of IO pins.
> >> 
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Vince Bridgers <vbridgers2013@gmail.com>
> >> Cc: Alan Tull <atull@altera.com>
> >> Cc: Thor Thayer <tthayer@altera.com>
> >> Cc: Dinh Nguyen <dinguyen@altear.com>
> 
> Please use dinguyen at opensource.altera.com in your V2.

Uh, sorry, must've been a copy-paste mistake from some other patch.
I already posted the V2, but if there's a need for V3, will keep that in mind.

> >> Cc: Olof Johansson <olof@lixom.net>
> 
> Dinh

Best regards,
Marek Vasut
