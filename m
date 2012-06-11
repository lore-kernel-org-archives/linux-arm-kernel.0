From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 11 Jun 2012 19:20:13 -0300
Subject: [PATCH 5/14] ARM: LPC32xx: Adjust dtsi file for MLC controller
 configuration
In-Reply-To: <1339412537-24485-6-git-send-email-stigge@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <1339412537-24485-6-git-send-email-stigge@antcom.de>
Message-ID: <CAAAP30GcHpxEEnO0vqROKwooRaMRudjfW7MD2=40VzJ8HGdQQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 8:02 AM, Roland Stigge <stigge@antcom.de> wrote:
> This patch takes into account that the MTD NAND MLC controller needs more
> registers, located actually before the previously allocated memory range,
> already starting at 200a8000 instead of 200b0000.
>
> Further, the interrupt for the controller is configured.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
