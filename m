From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 8 Nov 2011 15:47:59 +0000
Subject: [PATCH 40/41] ARM: restart: remove comments about adding code to
 arch_reset()
In-Reply-To: <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
Message-ID: <20111108154759.GE4405@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 06, 2011 at 05:53:30PM +0000, Russell King - ARM Linux wrote:
> arch_reset() is deprecated; systems should hook into system restart via
> the 'restart' method in the platforms machine description record.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks Russell!
