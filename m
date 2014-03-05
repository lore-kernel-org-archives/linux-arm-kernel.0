From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  5 Mar 2014 17:57:55 +0100
Subject: [PATCH 3/3] ARM: at91: at91sam9260: change at91_adc name
In-Reply-To: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1394038675-15809-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1394038675-15809-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't use "at91_adc" to refer to the at91_adc driver anymore as
the name is used to match an id_table.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index eda8d1679d40..0a0315920963 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1292,7 +1292,7 @@ static struct resource adc_resources[] = {
 };
 
 static struct platform_device at91_adc_device = {
-	.name		= "at91_adc",
+	.name		= "at91sam9260-adc",
 	.id		= -1,
 	.dev		= {
 				.platform_data		= &adc_data,
-- 
1.8.3.2
