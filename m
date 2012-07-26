From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:37:35 +0100
Subject: [PATCH 16/21] ASoC: Ux500: Enable MOP500 driver for Device Tree
In-Reply-To: <1343298534-13611-17-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-17-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726113734.GZ3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:49AM +0100, Lee Jones wrote:

>  arch/arm/mach-ux500/board-mop500-msp.c |    3 ---
>  sound/soc/ux500/mop500.c               |   41 ++++++++++++++++++++++++++++++++

There is no binding documentation here.  All bindings should be
documented.

> -	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
> -	platform_device_register(&snd_soc_mop500);
> -

This should be done separately - if it's going to be merged with
something it should be the patch that adds the relevant DT fragments.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/080dd61a/attachment.sig>
