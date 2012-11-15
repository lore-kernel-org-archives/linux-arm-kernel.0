From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 12:23:46 +0000
Subject: [PATCH 1/1] ARM: ux500: Describe UART platform registering issues
 more accurately
In-Reply-To: <1352968401-6092-1-git-send-email-lee.jones@linaro.org>
References: <1352968401-6092-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201211151223.46989.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 November 2012, Lee Jones wrote:
> UARTs no longer require call-back information, since the reset
> call-back was removed in 43b5f0d69291374f602ad8e1817f329573a59010.
> The only AUXDATA dependencies remaining for UARTs are DMA settings.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

What is the state of the DMA binding now? We originally wanted to merge
it for 3.7, but that didn't work out, so I hope we can get it done for
3.8.

	Arnd
