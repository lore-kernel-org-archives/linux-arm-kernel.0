From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 15 Jul 2014 14:28:34 +0800
Subject: [PATCH v4 2/2] can: m_can: add Bosch M_CAN controller support
In-Reply-To: <53C3D4BF.8030409@pengutronix.de>
References: <1405338041-19945-1-git-send-email-b29396@freescale.com>
 <1405338041-19945-2-git-send-email-b29396@freescale.com>
 <53C3D155.8080005@gmail.com> <53C3D4BF.8030409@pengutronix.de>
Message-ID: <20140715062833.GB9796@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 14, 2014 at 03:01:51PM +0200, Marc Kleine-Budde wrote:
[...]
> >> +#define IR_ERR_STATE    (IR_BO | IR_EW | IR_EP)
> >> +#define IR_ERR_LEC    (IR_STE    | IR_FOE | IR_ACKE | IR_BE | IR_CRCE)
> >> +#define IR_ERR_BUS    (IR_ERR_LEC | IR_WDI | IR_ELO | IR_BEU | IR_BEC \
> >> +            | IR_TOO | IR_MRAF | IR_TSW | IR_TEFL | IR_RF1L \
> >> +            | IR_RF0L)
> 
> Please move the '|' to the end of the line.
> 

Got it.

Regards
Dong Aisheng
