From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 2 Jul 2012 19:40:10 +0200 (CEST)
Subject: [PATCH 1/9] clocksource: time-armada-370-xp: Marvell Armada
 370/XP SoC timer driver
In-Reply-To: <1341243574-3258-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341243574-3258-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1341243574-3258-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <alpine.LFD.2.02.1207021939350.2793@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Jul 2012, Thomas Petazzoni wrote:

> From: Gregory Clement <gregory.clement@free-electrons.com>
> 
> Timer 0 is used as free-running clocksource, while timer 1 is used as
> clock_event_device.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Lior Amsalem <alior@marvell.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
