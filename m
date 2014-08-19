From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 19 Aug 2014 15:48:27 +0100
Subject: [PATCH v8 1/9] arm: versatile: Enable DEBUG_LL_UART_PL01X
In-Reply-To: <1408459715-10151-1-git-send-email-daniel.thompson@linaro.org>
References: <1404127855-30459-1-git-send-email-daniel.thompson@linaro.org>
 <1408459715-10151-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1408459715-10151-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This defconfig already enables DEBUG_LL and by default DEBUG_LL_UART_NONE
will be selected (but due to some back compability magic I'd like to
remove is not actually honoured). DEBUG_LL_UART_PL01X is a much saner
default.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/versatile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index d52b4ff..ea49d37 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -82,5 +82,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_USER=y
 CONFIG_DEBUG_LL=y
+CONFIG_DEBUG_LL_UART_PL01X=y
 CONFIG_FONTS=y
 CONFIG_FONT_ACORN_8x8=y
-- 
1.9.3
