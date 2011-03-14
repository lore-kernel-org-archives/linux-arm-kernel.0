From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 14 Mar 2011 15:15:49 +0100
Subject: [PATCH 1/2] i2c-pxa2xx: Fix register offsets
In-Reply-To: <1300024409-32587-1-git-send-email-anarsoul@gmail.com>
References: <1300024409-32587-1-git-send-email-anarsoul@gmail.com>
Message-ID: <4D7E2315.8010005@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> Fix regression that was introduced by dynamic register layout.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

After looking at my patch once again I noticed that I really mixed those
two up. Thanks for fixing this.

Sebastian
