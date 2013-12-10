From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 01:26:24 +0100
Subject: [PATCHv2] clk: socfpga: Map the clk manager base address in the
 clock driver
In-Reply-To: <1386633773-11713-1-git-send-email-dinguyen@altera.com>
References: <1386633773-11713-1-git-send-email-dinguyen@altera.com>
Message-ID: <201312100126.25150.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The clk manager's base address was being mapped in SOCFPGA's arch code and
> being extern'ed out to the clock driver. This method is not correct, and the
> arch code was not really doing anything with that clk manager anyways.
> 
> This patch moves the mapping of the clk manager's base address in the clock
> driver itself. Cleans up CLK_OF_DECLARE() into a single registration of all
> the clocks.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
