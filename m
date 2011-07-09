From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 11:15:28 +0100
Subject: [PATCH 02/17] ARM: Add cpu power management notifiers
In-Reply-To: <1310053830-23779-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20110709101528.GI4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:50:15PM +0100, Lorenzo Pieralisi wrote:
> During some CPU power modes entered during idle, hotplug and
> suspend, peripherals located in the CPU power domain, such as
> the GIC and VFP, may be powered down.  Add a notifier chain
> that allows drivers for those peripherals to be notified
> before and after they may be reset.

I defer comment on this until I see what the CPU_COMPLEX_* stuff is used
for.
