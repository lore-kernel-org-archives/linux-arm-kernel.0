From: arnd.bergmann@linaro.org (Arnd Bergmann)
Date: Wed, 23 Jul 2014 21:56:38 +0200
Subject: [PATCH CFT] arm: netx: Migrate DEBUG_LL macros to shared directory
In-Reply-To: <1406108463-11726-1-git-send-email-daniel.thompson@linaro.org>
References: <1406108463-11726-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <201407232156.38708.arnd.bergmann@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 July 2014, Daniel Thompson wrote:
> As part of the migration we introduce DEBUG_UART_PHYS/DEBUG_UART_VIRT
> which default to UART1 but allow a user to configure UART2 or UART3.
> We also introduce symbolic names for the registers and flags.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de
