From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 12:16:11 +0100
Subject: [PATCH 1/4] mmci: use StartBitErr to detect bad connections
In-Reply-To: <1309247845-17105-1-git-send-email-linus.walleij@stericsson.com>
References: <1309247845-17105-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110705111611.GW8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 28, 2011 at 09:57:25AM +0200, Linus Walleij wrote:
> Stresstesting insert/remove of SD-cards can trigger
> a StartBitErr. This made the driver to hang in forever
> waiting for a non ocurring data timeout.
> 
> This bit and interrupt is documented in the original
> PL180 TRM, just never implemented until now.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
> Reviewed-by: Jonas Aberg <jonas.aberg@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
