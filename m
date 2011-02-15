From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 11:35:04 +0000
Subject: [PATCH] ARM: S5PC210: add support for i2c PMICs on
	Universal_C210 board
In-Reply-To: <1297767555-13326-1-git-send-email-m.szyprowski@samsung.com>
References: <1297767555-13326-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110215113504.GF4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 11:59:15AM +0100, Marek Szyprowski wrote:
>  #include <mach/map.h>
> +#include <mach/gpio.h>

Need I say anything about this?
