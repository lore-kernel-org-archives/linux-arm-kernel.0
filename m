From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 23 Jul 2015 13:40:18 +0200
Subject: [PATCH] ARM: dts: Use stdout-path in STM32F429 Discovery board
In-Reply-To: <1437628173-9447-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1437628173-9447-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <55B0D2A2.9080604@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.07.2015 um 07:09 schrieb Maxime Coquelin:
> This patch replaces use of linux,stdout-path by stdout-path as per

s/by/with/

> "chosen" DT bindings documentation.
> 
> Doing that, the "console" argument is no more needed in kernel command
> line.
> 
> Reported-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f429-disco.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Other than that,

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
