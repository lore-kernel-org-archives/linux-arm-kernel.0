From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 14 Aug 2017 19:45:08 +0200
Subject: [PATCH] arm64: dts: realtek: Clean up RTD1295 UART reg property
In-Reply-To: <20170730111737.22888-1-afaerber@suse.de>
References: <20170730111737.22888-1-afaerber@suse.de>
Message-ID: <0c16bc3f-8e5d-3c35-a017-09000abd6e96@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.07.2017 um 13:17 schrieb Andreas F?rber:
> The downstream RTD1195 and apparently RTD1295 trees have a modified 8250
> serial driver that acknowledges its interrupts using the second reg area,
> which is an irq mux.
> 
> Drop these unused second reg entries for the UART nodes.
> 
> Fixes: 72a7786c0a0d ("ARM64: dts: Add Realtek RTD1295 and Zidoo X9S")
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied to v4.14/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git/log/?h=v4.14/dt64

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
