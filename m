From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sun, 16 Nov 2014 02:29:56 +0200
Subject: [PATCH v12 11/15] arm: omap1: Migrate debug_ll macros to use
 8250.S
In-Reply-To: <1414148076-12685-12-git-send-email-daniel.thompson@linaro.org>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
 <1414148076-12685-12-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20141116002956.GA13220@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 24, 2014 at 11:54:32AM +0100, Daniel Thompson wrote:
> +	config DEBUG_OMAP1UART1
> +		bool "Kernel low-level debugging via OMAP1 UART1"
> +		depends on ARCH_OMAP1
> +		select DEBUG_UART_8250
> +		help
> +		  Say Y here if you want kernel low-level debugging support
> +		  on OMAP1 based platforms (expect OMAP730) on the UART1.
[...]
> +		  on OMAP1 based platforms (expect OMAP730) on the UART2.
[...]
> +		  on OMAP1 based platforms (expect OMAP730) on the UART3.
                                            ^^^^^^

Spelling again wrong. I think it was already corrected in v11?

A.
