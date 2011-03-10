From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Mar 2011 15:10:14 +0000
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <201103101602.19241.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103101529.25661.arnd@arndb.de>
	<20110310144455.GG22195@opensource.wolfsonmicro.com>
	<201103101602.19241.arnd@arndb.de>
Message-ID: <20110310151014.GA826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 04:02:18PM +0100, Arnd Bergmann wrote:
> The one thing that really doesn't belong in /sys/devices/platform/
> however are devices that are clearly children of some other
> device, e.g. a UART behind MFD behind I2C behind AHB.

Who ever thought about putting a UART behind I2C ?  That's insane!
