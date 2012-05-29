From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 May 2012 15:39:44 +0000
Subject: [PATCH 1/2] serial/8250: Add LPC3220 standard UART type
In-Reply-To: <1338282570-19799-1-git-send-email-stigge@antcom.de>
References: <1338282570-19799-1-git-send-email-stigge@antcom.de>
Message-ID: <201205291539.44705.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 May 2012, Roland Stigge wrote:
> 
> LPC32xx has "Standard" UARTs that are actually 16550A compatible but have
> bigger FIFOs. Since the already supported 16X50 line still doesn't match here,
> we agreed on adding a new type.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
