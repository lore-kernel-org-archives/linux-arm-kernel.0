From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Mar 2012 09:17:17 -0800
Subject: [PATCH] pinctrl: fix the pin descriptor kerneldoc
In-Reply-To: <1330703621-4044-1-git-send-email-linus.walleij@stericsson.com>
References: <1330703621-4044-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861969@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Friday, March 02, 2012 8:54 AM:
> The introduction of the owner field on the pin descriptor was not
> properly documented so fix this up.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I did have this fix buried later in my patch series, but it's probably a
good idea to patch it separately before then.

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
