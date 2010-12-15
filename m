From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 16:36:19 +0100
Subject: [PATCH 4/7] msm: Board file for MSM8960 simulator
In-Reply-To: <1292384961-8851-5-git-send-email-stepanm@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-5-git-send-email-stepanm@codeaurora.org>
Message-ID: <201012151636.19868.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Stepan Moskovchenko wrote:
> +#ifdef CONFIG_MSM_DEBUG_UART
> +       .phys_io  = MSM_DEBUG_UART_PHYS,
> +       .io_pg_offst = ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
> +#endif

These fields are no longer present in the machine description,
AFAICT.

	Arnd
