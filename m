From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 9 Jun 2016 15:34:19 +0200
Subject: [PATCH] ARM: Kirkwood: fix kirkwood_pm_init() declaration/type
In-Reply-To: <1465473432-24323-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465473432-24323-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160609133419.GJ30205@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 12:57:12PM +0100, Ben Dooks wrote:
> The kirkwood-pm.c was missing the include of kirkwood-pm.h to
> define the kirkwood_pm_init() function. However once this is
> included, the types do not match.
> 
> Fixup the include, and then the prototype to avoid the following
> warning:
> 
> arch/arm/mach-mvebu/kirkwood-pm.c:69:12: warning: symbol 'kirkwood_pm_init' was not declared. Should it be static?
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>


Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
