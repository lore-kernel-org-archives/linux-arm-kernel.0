From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Nov 2014 12:01:49 +0100
Subject: [PATCH 1/7] dmaengine: at_xdmac: prefer usage of
 readl/writel_relaxed
In-Reply-To: <1415875965-6905-2-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
 <1415875965-6905-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <2791155.z0l2TZezWO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 November 2014 11:52:39 Ludovic Desroches wrote:
> _relaxed version of readl and writel are not implemented on all
> architecture so COMPILE_TEST has to be removed in order to not cause
> some build failures.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 

I've queued up Will Deacon's series to enable the relaxed accessors
on all architectures, so the Kconfig change should no longer
be required in 3.19.

	Arnd
