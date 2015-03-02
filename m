From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Mar 2015 22:33:06 +0100
Subject: [PATCH 1/5] ARM: orion: move watchdog setup to mach-orion5x
In-Reply-To: <1425328618-894030-2-git-send-email-arnd@arndb.de>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
 <1425328618-894030-2-git-send-email-arnd@arndb.de>
Message-ID: <20150302213306.GC2375@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 09:36:54PM +0100, Arnd Bergmann wrote:
> The watchdog device node is created in plat-orion/common.c
> but depends on the bridge address that is platform specific,
> so as a preparation for orion multiplatform support, we should
> move it out of the common code into orion5x.

If i remember correctly, RMK patchset for the Dove PMU allows the
watchdog to be enabled for Dove.

	 Andrew
