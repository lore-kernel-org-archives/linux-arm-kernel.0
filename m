From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 03 May 2013 16:01:47 +0200
Subject: [PATCH] ARM: sun4i: cubieboard: Enable the i2c controllers
In-Reply-To: <1367498266-1246-1-git-send-email-emilio@elopez.com.ar>
References: <1367498266-1246-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <5183C34B.8050801@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

Le 02/05/2013 14:37, Emilio L?pez a ?crit :
> The Cubieboard makes use of the first two i2c controllers found on the
> Allwinner A10; i2c-0 is used internally for the PMIC, while i2c-1
> is exposed on the board headers. This patch enables them in the device
> tree.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Thanks for this patch.

I'll merge it in my i2c patchset, so that every thing stays together.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
