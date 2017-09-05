From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 5 Sep 2017 23:37:52 +0200
Subject: [PATCH v4 18/28] ARM: dts: s500-guitar-bb-rev-b: Add fake uart3
 clock
In-Reply-To: <20170606005426.26446-19-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-19-afaerber@suse.de>
Message-ID: <5f7e0538-5cd5-6052-28bf-3cb9c07d7748@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Add a fixed-clock for baudrate 115200.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3 -> v4: unchanged
>  
>  v2: new
>  
>  arch/arm/boot/dts/s500-guitar-bb-rev-b.dts | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied to v4.14/dt:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.14/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
