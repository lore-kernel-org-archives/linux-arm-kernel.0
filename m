From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Sep 2011 18:45:58 +0200
Subject: [PATCH v2 2/3] ARM: iwmmxt: Port problematic iwmmxt support code
	to v7/Thumb-2
In-Reply-To: <1315497854-13311-3-git-send-email-dave.martin@linaro.org>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-3-git-send-email-dave.martin@linaro.org>
Message-ID: <201109081845.58260.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 September 2011, Dave Martin wrote:
> The iwmmxt code contains some code to implement a pseudo-ISB, but
> this is not buildable for Thumb-2.
> 
> This patch replaces the pseudo-ISB with a real one for Thumb-2
> kernels.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
>  arch/arm/kernel/iwmmxt.S |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>
