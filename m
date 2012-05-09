From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 19:21:42 +0000
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <201205091921.43299.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Marc Zyngier wrote:
> 
> The GICv2 can have virtualization extension support, consisting
> of an additional set of registers and interrupts. Add the necessary
> binding to the GIC DT documentation.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Would it make sense to add a way to detect whether a GIC is virtual
or real? Maybe an optional empty "virtual-gic" property or an additional
"compatible" value. Even if we don't need it now, it might come in handy
if we require it already.

	Arnd
