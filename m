From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 09 Nov 2012 16:51:44 +0400
Subject: [PATCH] i2c: at91: fix compilation issue due to header move
In-Reply-To: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
References: <1352455900-21074-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <509CFC60.6000203@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-11-2012 14:11, ludovic.desroches at atmel.com wrote:

> From: Ludovic Desroches <ludovic.desroches@atmel.com>

> arch/arm/mach-at91/include/mach/at_hdmac.h has been move to
> include/linux/platform_data/dma-atmel.h, commit 7cdc39e.

    Need to also specify that commit's summary in parens.

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

WBR, Sergei
