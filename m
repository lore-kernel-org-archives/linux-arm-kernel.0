From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 29 Feb 2012 10:03:57 -0800
Subject: [PATCH v2] pinctrl: make the pinmux-pins more helpful
In-Reply-To: <1330538332-16088-1-git-send-email-linus.walleij@stericsson.com>
References: <1330538332-16088-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BDDF20C2@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Wednesday, February 29, 2012 10:59 AM:
> The debugfs file pinmux-pins used to tell which function was
> enabled but now states simply which device owns the pin. Being
> owned by the pinctrl driver itself means just that it's hogged
> so be a bit more helpful by printing that.
> 
> ChangeLog v1->v2:
> - Preserve the self-referential owner field, just clarify that
>   when the pin controller states itself as owner this means
>   that it's hogged.
> 
> Acked-by: Dong Aisheng <dong.aisheng@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Exactly what I want, thanks.

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
