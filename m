From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Nov 2011 15:35:46 -0800
Subject: [PATCH 40/41] ARM: restart: remove comments about adding code
 to arch_reset()
In-Reply-To: <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
Message-ID: <20111110233545.GA31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 09:31]:
> arch_reset() is deprecated; systems should hook into system restart via
> the 'restart' method in the platforms machine description record.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
