From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 11 Jun 2012 19:25:35 -0300
Subject: [PATCH 13/14] ARM: LPC32xx: High Speed UART configuration via DT
In-Reply-To: <1339412537-24485-14-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-14-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30F3TyQi_zouCuxGvOXroAxHTgypD1NFZEpadPmjFFYEPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 8:02 AM, Roland Stigge <stigge@antcom.de> wrote:
> This patch fixes the DTS files for the High Speed UARTs 1, 2 and 7 of the
> LPC32xx SoC, adjusting the compatible strings, adding interrupts and status
> configuration. On the PHY3250 reference board, UART2 is enabled.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
