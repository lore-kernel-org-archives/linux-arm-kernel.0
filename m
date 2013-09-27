From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 22:55:23 +0100
Subject: [PATCH v2] ARM: new platform for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <201309272344.01386.arnd@arndb.de>
References: <1379447884-14025-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201309172245.25367.arnd@arndb.de> <20130926094251.GK16106@pengutronix.de>
 <201309272344.01386.arnd@arndb.de>
Message-ID: <20130927215523.GO12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 11:44:01PM +0200, Arnd Bergmann wrote:
> * Do you need any other patches (unrelated to EFM32) to run NOMMU on a
> recent kernel? When I last tried, I could not get any NOMMU build to work
> at all.

My Oki platform builds fine.  The core noMMU stuff seems fine.
