From: thommycheck@gmx.de (Thomas Kunze)
Date: Mon,  5 Oct 2009 23:35:25 +0200
Subject: [PATCH 1/9] collie: fix scoop convesion to new api
In-Reply-To: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
References: <1254778533-3529-1-git-send-email-thommycheck@gmx.de>
Message-ID: <1254778533-3529-2-git-send-email-thommycheck@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Thomas Kunze <thommycheck@gmx.de>
---
 arch/arm/mach-sa1100/collie.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index bbf2ebc..b629cba 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -56,6 +56,7 @@ static struct resource collie_scoop_resources[] = {
 static struct scoop_config collie_scoop_setup = {
 	.io_dir 	= COLLIE_SCOOP_IO_DIR,
 	.io_out		= COLLIE_SCOOP_IO_OUT,
+	.gpio_base	= COLLIE_SCOOP_GPIO_BASE,
 };
 
 struct platform_device colliescoop_device = {
-- 
1.6.0.4
