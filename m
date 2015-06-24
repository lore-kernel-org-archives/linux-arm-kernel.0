From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 24 Jun 2015 22:13:38 +0200
Subject: [PATCH 3/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1435126625-9634-4-git-send-email-s.hauer@pengutronix.de>
References: <1435126625-9634-1-git-send-email-s.hauer@pengutronix.de>
 <1435126625-9634-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <3811196.182kcVQh3D@ubix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 24, 2015 08:17:04 AM Sascha Hauer wrote:
> This adds a power domain driver for the Mediatek SCPSYS unit.
> 
> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. The tasks include thermal
> measurement, dynamic voltage frequency scaling (DVFS), interrupt
> filter and lowlevel sleep control. The System Power Manager (SPM)
> inside the SCPSYS is for the MTCMOS power domain control.
> 
> For now this driver only adds power domain support, the more
> advanced features are not yet supported. The driver implements
> the generic PM domain device tree bindings, the first user will
> most likely be the Mediatek AFE audio driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to v4.2-next/soc
