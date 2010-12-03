From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 19:14:55 +0000
Subject: [PATCH -next] arm: trivial: add missing argument to printk
In-Reply-To: <1291403172-2438-1-git-send-email-gadiyar@ti.com>
References: <1291403172-2438-1-git-send-email-gadiyar@ti.com>
Message-ID: <20101203191455.GK30898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 04, 2010 at 12:36:12AM +0530, Anand Gadiyar wrote:
> Patch "ARM: CPU hotplug: move cpu_killed completion to core code"
> accidentally left out an argument to a printk call. This introduces
> the following build warning - fix this.

Already caught this.
