From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Mar 2014 09:01:49 -0700
Subject: [PATCH 49/75] ARM: l2c: fix register naming
In-Reply-To: <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYH-0007GB-3M@rmk-PC.arm.linux.org.uk>
Message-ID: <20140328160148.GE24308@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> We have a mixture of different devices with different register layouts,
> but we group all the bits together in an opaque mess.  Split them out
> into those which are L2C-310 specific and ones which refer to earlier
> devices.  Provide full auxiliary control register definitions.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
