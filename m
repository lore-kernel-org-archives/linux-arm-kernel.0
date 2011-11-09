From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 14:29:50 -0800
Subject: [PATCH 4/7] ARM: restart: move reboot failure handing into
 machine_restart()
In-Reply-To: <E1RN6aU-0001N8-Ol@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6aU-0001N8-Ol@rmk-PC.arm.linux.org.uk>
Message-ID: <20111109222950.GQ31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 09:01]:
> Move the failure to reboot into machine_restart() to always catch
> this condition, even if a platform decides to hook the restarting
> via arm_pm_restart().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
