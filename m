From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 19:34:16 +0100
Subject: [RESEND PATCH] clk: socfpga: Remove socfpga_init_clocks
In-Reply-To: <1386693938-29657-1-git-send-email-dinguyen@altera.com>
References: <1386693938-29657-1-git-send-email-dinguyen@altera.com>
Message-ID: <201312101934.17135.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> The only thing that socfpga_init_clocks was doing setting up the smp_twd clock.
> Now that twd-timer's clock phandle is populated in the DTS, we can remove
> this function.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
