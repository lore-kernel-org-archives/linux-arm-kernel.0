From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 5 Sep 2017 23:29:44 +0200
Subject: [PATCH v4 17/28] ARM64: dts: actions: s900-bubblegum-96: Add fake
 uart5 clock
In-Reply-To: <20170606005426.26446-18-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-18-afaerber@suse.de>
Message-ID: <55e81df3-3b49-0037-1396-35e43eb89ce5@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Give the serial driver a fixed-clock as input for baudrate 115200.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3 -> v4: unchanged
>  
>  v2: new
>  
>  arch/arm64/boot/dts/actions/s900-bubblegum-96.dts | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to v4.14/dt64:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.14/dt64

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
