From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 Dec 2010 12:37:50 +0200
Subject: [PATCH v2] arm: mach-omap2: remove NULL board_mux from board files
In-Reply-To: <1291283622-16359-1-git-send-email-aaro.koskinen@nokia.com>
References: <1291283622-16359-1-git-send-email-aaro.koskinen@nokia.com>
Message-ID: <20101202103750.GM5429@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 11:53:42AM +0200, Aaro Koskinen wrote:
>diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>index 350c04f..e224ab5 100644
>--- a/arch/arm/mach-omap2/mux.h
>+++ b/arch/arm/mach-omap2/mux.h
>@@ -133,6 +133,8 @@ static inline int omap_mux_init_signal(char *muxname, int val)
> 	return 0;
> }
>
>+static struct omap_board_mux *board_mux __initdata __attribute__((unused));

how about __unused ??

-- 
balbi
