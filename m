From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Mar 2010 09:54:13 +0000
Subject: Cleanup ARM platform support, and add Versatile Express support
Message-ID: <20100305095413.GA3897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What follows is a rather large patch set (tested by others and myself)
which cleans up the Integrator, Versatile and Realview platform support,
and adds support for the ARM Versatile Express platform.

These are inherently interlinked since they all reuse the same IP.
