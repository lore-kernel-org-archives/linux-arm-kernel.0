From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 11 Jun 2012 19:23:45 -0300
Subject: [PATCH 12/14] ARM: LPC32xx: DT conversion of Standard UARTs
In-Reply-To: <1339412537-24485-13-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-13-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30Gf4+tt3AbqcekqQCmHqS=8-_PVe+69u2tNOoLN6KfAuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 8:02 AM, Roland Stigge <stigge@antcom.de> wrote:
> This patch switches from static serial driver initialization to devicetree
> configuration. This way, the Standard UARTs of the LPC32xx SoC can be enabled
> individually via DT.
>
> E.g., instead of Kconfig configuration, the phy3250.dts activates
> UARTs 3 and 5.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
