From: wg@grandegger.com (Wolfgang Grandegger)
Date: Thu, 17 Sep 2009 11:50:49 +0200
Subject: 
In-Reply-To: <1253180254-11910-1-git-send-email-mkl@pengutronix.de>
References: <1253180254-11910-1-git-send-email-mkl@pengutronix.de>
Message-ID: <4AB20679.2040602@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde wrote:
> Hi,
> 
> This patch series adds support for the Atmel CAN controller as found
> on the AT91SAM9263.
> 
> It adds the at91_can to the generic device definition, activates the CAN
> controller on the at91sam9263ek and adds the driver itself.
> 
> Changes since V1:
> - let Kconfig depend on CAN_DEV
> - add example how driver is used in baord file
> 
> Please review and consider for inclusion.

A Vx patch suffix would be nice next time.

> cheers, Marc
> 
> Marc Kleine-Budde (3):
>       at91sam9263: add at91_can device to generic device definition
>       at91sam9263ek: activate at91 CAN controller
>       at91_can: add driver for Atmel's CAN controller on AT91SAM9263

I have just added my "signed-off-by" for the Socket-CAN patch #3. Don't
known who will take care of the other patches.

Wolfgang.
