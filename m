From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Dec 2011 10:34:12 +0000
Subject: [PATCH 1/2] ARM: S3C64XX: Fix the memory mapped GPIOs on
 Cragganmore
In-Reply-To: <029301ccc5de$58557970$09006c50$%kim@samsung.com>
References: <1325121813-2066-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <029301ccc5de$58557970$09006c50$%kim@samsung.com>
Message-ID: <20111229103412.GC2909@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 01:00:04PM +0900, Kukjin Kim wrote:

> And Mark, how about using DEFINE_RES_XXX() like following?

That's fine, though the mmgpio one does need to have the name added.
