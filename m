From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 19 Sep 2017 09:59:11 +0200
Subject: [PATCH 0/2] ARM: owl: Add CubieBoard6
In-Reply-To: <20170911005805.10116-1-afaerber@suse.de>
References: <20170911005805.10116-1-afaerber@suse.de>
Message-ID: <36278351-87a7-d6f9-d9b4-af636e4be3d8@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 11.09.2017 um 02:58 schrieb Andreas F?rber:
> Andreas F?rber (2):
>   dt-bindings: arm: actions: Add CubieBoard6
>   ARM: dts: owl-s500: Add CubieBoard6
> 
>  Documentation/devicetree/bindings/arm/actions.txt |  1 +
>  arch/arm/boot/dts/Makefile                        |  1 +
>  arch/arm/boot/dts/owl-s500-cubieboard6.dts        | 44 +++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 arch/arm/boot/dts/owl-s500-cubieboard6.dts

Applied to v4.15/dt:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.15/dt

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
