From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Dec 2011 10:32:37 +0000
Subject: [PATCH] ARM: S3C64XX: Fix interrupt configuration for PCA935x on
 Cragganmore
In-Reply-To: <028d01ccc5db$0e453cb0$2acfb610$%kim@samsung.com>
References: <1325121979-3609-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <028d01ccc5db$0e453cb0$2acfb610$%kim@samsung.com>
Message-ID: <20111229103237.GB2909@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 12:36:31PM +0900, Kukjin Kim wrote:

> OK, so do you want to apply this before v3.2?

The problem is mostly cosmetic as the chip isn't actually used by
current cosmetics so no need to try to get it into 3.2.
