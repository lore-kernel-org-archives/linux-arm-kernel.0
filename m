From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 19:40:00 +0800
Subject: [PATCH 09/10 RESEND] spi: Add SSP/SPI device tree documentation
In-Reply-To: <201207242143.49038.marex@denx.de>
References: <1343076052-27312-1-git-send-email-marex@denx.de>
 <1343076052-27312-10-git-send-email-marex@denx.de>
 <500EE64B.8080103@mvista.com> <201207242143.49038.marex@denx.de>
Message-ID: <20120728113957.GE2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 09:43:48PM +0200, Marek Vasut wrote:
> This is actually not the first place I was curious about in the imx28 DTS ... 
> yes, the size is 0x2000, but "2000" as is is used in multiple places across 
> imx28. Shawn?
> 
It seems that I overlooked the problem when it got introduced at the
first place.  I will send a patch to fix it.  Thanks for spotting it.

-- 
Regards,
Shawn
