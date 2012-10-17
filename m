From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Oct 2012 18:48:05 +0100
Subject: [RFC PATCH] ARM: SMP: consolidate holding pen
In-Reply-To: <1350487967-2555-1-git-send-email-marc.zyngier@arm.com>
References: <1350487967-2555-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20121017174804.GK21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 04:32:47PM +0100, Marc Zyngier wrote:
> As with other bits of the SMP code, platforms have duplicated a lot
> of the RealView implementation. As an effort to slightly reduce
> the clutter, make the plat-versatile version of the holding pen
> a standard part of the SMP framework.
> 
> Platforms can still provide their own, but those who carried an exact
> duplicate of the Realview code are switched to the common implementation.

My position on this hasn't changed.
