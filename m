From: wad@chromium.org (Will Drewry)
Date: Tue, 31 May 2011 22:10:39 -0500
Subject: [PATCH v3 07/13] arm: select HAVE_SECCOMP_FILTER
In-Reply-To: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
Message-ID: <1306897845-9393-7-git-send-email-wad@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable support for CONFIG_SECCOMP_FILTER by selecting HAVE_SECCOMP_FILTER by
default.

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..4725fbc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -16,6 +16,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
 	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL)
 	select HAVE_FUNCTION_GRAPH_TRACER if (!THUMB2_KERNEL)
+	select HAVE_SECCOMP_FILTER
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
-- 
1.7.0.4
