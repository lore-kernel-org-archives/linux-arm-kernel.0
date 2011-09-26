From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Sep 2011 12:21:51 +0100
Subject: [PATCH 1/4] ARM i.MX avic: add handle_irq function
In-Reply-To: <1317030369-29352-2-git-send-email-s.hauer@pengutronix.de>
References: <1317030369-29352-1-git-send-email-s.hauer@pengutronix.de>
	<1317030369-29352-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110926112151.GE22455@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 26, 2011 at 11:46:06AM +0200, Sascha Hauer wrote:
> +void avic_handle_irq(struct pt_regs *);
> +
> +#define imx1_handle_irq avic_handle_irq
> +#define imx21_handle_irq avic_handle_irq
> +#define imx25_handle_irq avic_handle_irq
> +#define imx27_handle_irq avic_handle_irq
> +#define imx31_handle_irq avic_handle_irq
> +#define imx35_handle_irq avic_handle_irq

Is there really something wrong in knowing (elsewhere) that mx1..mx35 all
use the avic irq handler?
