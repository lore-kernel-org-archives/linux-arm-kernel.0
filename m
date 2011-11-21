From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 21 Nov 2011 14:47:49 +0100
Subject: [PATCH v2] arm/imx: fix the references to ARCH_MX3
In-Reply-To: <1320997034-10051-1-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-3-git-send-email-shawn.guo@linaro.org>
 <1320997034-10051-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1321883269.32195.9.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-11-11 at 15:37 +0800, Shawn Guo wrote: 
> The config symbol ARCH_MX3 has been removed by commit 'a89cf59
> arm/imx: merge i.MX3 and i.MX6', and it should not be referenced
> any more.
> 
> The patch also change ARCH_MX* to SOC_IMX* for other platforms.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Changes since v1:
>  * Drop changes on drivers/dma/Kconfig, as Sascha alreay has a patch
>    to fix it.

This appears to be to the patch that ended up as commit 59198b6cb2 in
the mainline tree. But in mainline there are still those two references
to ARCH_MX3 in drivers/dma/Kconfig. Can I ask what happened to this
patch of Sascha that Shawn mentions?


Paul Bolle
