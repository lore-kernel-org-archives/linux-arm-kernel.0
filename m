From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 1 Feb 2012 15:37:47 -0800
Subject: [PATCH v2] pinctrl: delete raw device pointers in pinmux maps
In-Reply-To: <1328121721-3438-1-git-send-email-linus.walleij@stericsson.com>
References: <1328121721-3438-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E124918@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Wednesday, February 01, 2012 11:42 AM:
> After discussion with Mark Brown in an unrelated thread about
> ADC lookups, it came to my knowledge that the ability to pass
> a struct device * in the regulator consumers is just a
> historical artifact, and not really recommended. Since there
> are no in-kernel users of these pointers, we just kill them
> right now, before someone starts to use them.
> 
> Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Documentation,
Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
