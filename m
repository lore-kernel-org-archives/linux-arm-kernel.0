From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Nov 2011 14:30:20 -0800
Subject: [PATCH 5/7] ARM: restart: remove argument to setup_mm_for_reboot()
In-Reply-To: <E1RN6ap-0001NC-9G@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6ap-0001NC-9G@rmk-PC.arm.linux.org.uk>
Message-ID: <20111109223019.GR31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 09:02]:
> setup_mm_for_reboot() doesn't make use of its argument, so remove it.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
