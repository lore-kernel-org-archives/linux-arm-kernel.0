From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Feb 2016 23:25:34 +0100
Subject: [PATCH 22/50] pinctrl: pxa: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-23-git-send-email-ldewangan@nvidia.com> (Laxman
 Dewangan's message of "Wed, 24 Feb 2016 18:45:47 +0530")
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-23-git-send-email-ldewangan@nvidia.com>
Message-ID: <8760xbun1d.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laxman Dewangan <ldewangan@nvidia.com> writes:

> Use devm_pinctrl_register() for pin control registration and clean
> the error path.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: linux-arm-kernel at lists.infradead.org
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
