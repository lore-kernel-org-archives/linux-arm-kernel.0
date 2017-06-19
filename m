From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 06:01:32 +0200
Subject: [PATCH v4 25/28] ARM: dts: s500: Add SPS node
In-Reply-To: <20170606005426.26446-26-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-26-afaerber@suse.de>
Message-ID: <304a35b8-825f-878b-6e14-9662ab9ad8ca@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.06.2017 um 02:54 schrieb Andreas F?rber:
> Add Smart Power System node for PM domains.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v3 -> v4:
>  * Extended commit message
>  * Split off association of power-domains (avoids include/dt-bindings/ dependency)
>  
>  v3: new
>  
>  arch/arm/boot/dts/s500.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to linux-actions.git v4.13/dt branch:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
