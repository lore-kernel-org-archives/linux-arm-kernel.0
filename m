From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 May 2011 08:47:25 +0100
Subject: [PATCH] [media] at91: add Atmel Image Sensor Interface (ISI)
	support
In-Reply-To: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>
References: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20110512074725.GA1356@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 03:42:18PM +0800, Josh Wu wrote:
> +err_alloc_isi:
> +	clk_disable(pclk);

clk_put() ?
