From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 21:14:36 +0000
Subject: [PATCH 09/16] ARM: pxa: don't treat NULL clk as an error
In-Reply-To: <1294749833-32019-10-git-send-email-jamie@jamieiles.com>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
	<1294749833-32019-10-git-send-email-jamie@jamieiles.com>
Message-ID: <20110111211436.GO11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 12:43:46PM +0000, Jamie Iles wrote:
> clk_get() returns a struct clk cookie to the driver and some platforms
> may return NULL if they only support a single clock.  clk_get() has only
> failed if it returns a ERR_PTR() encoded pointer.

Good catch.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
