From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Feb 2013 10:23:26 +0000
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <512BF81A.3080700@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org>
Message-ID: <201302261023.26939.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 February 2013, Stephen Warren wrote:
> Is there any other alternative I'm not seeing? Having the kernel
> suddenly become incompatible with any currently extant bootloader when I
> enable CONFIG_MULTIPLATFORM doesn't seem like a great idea.

Could we make those errata be run-time enabled only when not booting
in secure mode?

	Arnd
