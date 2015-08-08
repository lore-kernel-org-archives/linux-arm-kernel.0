From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 08 Aug 2015 12:27:25 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: set correct dwc2 params for
 cortex-a9 socs
In-Reply-To: <1617149.AMXNNUATDo@diego>
References: <1617149.AMXNNUATDo@diego>
Message-ID: <1512558.RdU3anUM3L@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 2. August 2015, 23:43:12 schrieb Heiko St?bner:
> According to the manual, the fifo sizes are the same as on later socs
> like the rk3288 and this also fixes an error about "insufficient fifo
> memory", as it seems the values read from the ip are wrong.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

applied all 3 patches to my dts branch
