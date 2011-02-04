From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Feb 2011 10:29:43 +0000
Subject: [PATCH RFC] arm: omap3evm: Add support for an MT9M032 based
	camera board.
In-Reply-To: <1295389936-3238-1-git-send-email-martin@neutronstar.dyndns.org>
References: <1295389936-3238-1-git-send-email-martin@neutronstar.dyndns.org>
Message-ID: <20110204102943.GC15004@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 11:32:16PM +0100, Martin Hostettler wrote:
> +#include <asm/gpio.h>

Please use linux/gpio.h in future.
