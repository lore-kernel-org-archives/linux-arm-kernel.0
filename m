From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jun 2012 09:09:40 +0000
Subject: [PATCH v3 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <1339746250-26650-2-git-send-email-gregory.clement@free-electrons.com>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <201206150909.41173.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 June 2012, Gregory Clement wrote:
> Timer 0 is used as free-running clocksource, while timer 1 is used as
> clock_event_device.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>

Looks fine to me, but you forgot to Cc the clocksource maintainers.
This will need an Ack from John and/or Thomas.

	Arnd
