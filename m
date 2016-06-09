From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Jun 2016 15:32:34 +0200
Subject: [PATCH] ARM: Kirkwood: make
 kirkwood_disable_mbus_error_propagation() static
In-Reply-To: <1465473145-20826-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465473145-20826-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160609133234.GI30205@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 12:52:25PM +0100, Ben Dooks wrote:
> The kirkwood_disable_mbus_error_propagation is not exported or declared
> elsewhere, so make it static to avoid the following warning:
> 
> arch/arm/mach-mvebu/kirkwood.c:153:6: warning: symbol 'kirkwood_disable_mbus_error_propagation' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
