From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 27 Jul 2017 22:58:08 +0200
Subject: [PATCH v4 26/28] ARM: dts: s500: Set power domains for CPU2 and
 CPU3
In-Reply-To: <20170606005426.26446-27-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-27-afaerber@suse.de>
Message-ID: <819d3189-e3f7-5b6c-a292-693c241b1727@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> CPU2 has its own power domain PD_CPU2, and CPU3 has PD_CPU3.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4: new (split off due to dt-bindings dependency)
>  
>  arch/arm/boot/dts/s500.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Applied to v4.14/dt:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.14/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
