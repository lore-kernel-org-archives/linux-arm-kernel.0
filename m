From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Nov 2014 13:52:48 -0200
Subject: [PATCH] ARM: dts: imx6qdl: Fix CODA960 interrupt order
In-Reply-To: <1417188226-21756-1-git-send-email-p.zabel@pengutronix.de>
References: <1417188226-21756-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <CAOMZO5AShN=bsQBZ6Xkg88Z8r9b9zktfBzpCXOGOuXS=4JuQKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 1:23 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Commit a04a0b6fed4f ("ARM: dts: imx6qdl: Enable CODA960 VPU") lost the
> fix for the CODA960 interrupt order during a rebase before being applied.
> This patch adds the missing bit and brings the interrupts and
> interrupt-names properties back in sync.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Thanks, Philipp. This fixes the VPU timeout I was seeing:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
