From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 May 2010 10:06:36 +0100
Subject: [PATCH v2] ARM: S5P: Add System Timer
In-Reply-To: <1273827090-26635-1-git-send-email-kgene.kim@samsung.com>
References: <1273827090-26635-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100514090636.GA10339@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 05:51:30PM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko@samsung.com>
> 
> This patch addes system timer for Samsung S5P series SoCs

You really should be using the clockevents/clocksource code rather
than trying to implement the old gettimeoffset stuff.
