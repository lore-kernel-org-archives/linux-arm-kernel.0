From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Thu, 23 Nov 2017 14:00:26 +0100
Subject: [PATCH 3/5] ARM: dts: imx: Add an cpu0 label for imx6dl devices.
In-Reply-To: <20171123125600.41562-4-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171123125600.41562-4-jan.tuerk@emtrion.com>
Message-ID: <975d0b1f-46d7-8ae8-5455-a3fe7c0debc9@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 23.11.2017 um 13:55 schrieb Jan Tuerk:
> Adding the label cpu0 allows the adjustment of cpu-parameters
> by reference in overlaying dtsi files in the same way as it
> is possible for imx6q devices.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
>  arch/arm/boot/dts/imx6dl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Andreas F?rber <afaerber@suse.de>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
