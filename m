From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jul 2011 11:05:06 +0100
Subject: [PATCH 1/2] SPI: S5PC100: Enable the SPI driver for S5PC100
In-Reply-To: <1309801476-29678-1-git-send-email-padma.v@samsung.com>
References: <1309801476-29678-1-git-send-email-padma.v@samsung.com>
Message-ID: <20110705100506.GT8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 01:44:35PM -0400, Padmavathi Venna wrote:
>  config SPI_S3C64XX
>  	tristate "Samsung S3C64XX series type SPI"
> -	depends on (ARCH_S3C64XX || ARCH_S5P64X0)
> +	depends on (ARCH_S3C64XX || ARCH_S5P64X0 || ARCH_S5PC100)

Just get rid of the unnecessary parens here.
