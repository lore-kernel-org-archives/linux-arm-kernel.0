From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 24 Feb 2016 18:22:06 +0100 (CET)
Subject: [PATCH 00/50] pinctrl: Add and use devm_ apis for
 pinctrl_{register, unregister}
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <771728522.222286.b52ca77e-fe5e-4536-8e14-525e9a846cdc.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laxman,

> Laxman Dewangan <ldewangan@nvidia.com> hat am 24. Februar 2016 um 14:15
> geschrieben:
>
>
> Add resource manageemnt APIs fro pinctrl_register() and pinctrl_unregister()
> and use these new APIs on hw driver to reduce the error path code and
> remove callback for driver.
>

just for interest: why didn't you patch freescale/pinctrl-mxs.c?

Regards
Stefan
