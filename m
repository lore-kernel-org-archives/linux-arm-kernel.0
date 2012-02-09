From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2012 08:48:59 +0000
Subject: [PATCH v6 15/15] ARM: hotplug: add cpu_lowpower as an
 alternative to cpu_die
In-Reply-To: <1328661059-24584-16-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120209084859.GP889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 12:30:59AM +0000, Marc Zyngier wrote:
> Most platforms don't actually implement cpu_die, but instead
> a "go into low power mode" operation.

NAK.  Don't encourage this broken low power stuff from platform
people.
