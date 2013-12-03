From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 13:06:42 -0700
Subject: [PATCH 1/2] ARM: dts: tegra: Header file for pinctrl constants
In-Reply-To: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <529E39D2.9000705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 06:55 AM, Laxman Dewangan wrote:
> Defines pincontrol constants to use from Tegra's DTS file
> for tegra pincontrol properties option.

> diff --git a/include/dt-bindings/pinctrl/pinctrl-tegra.h b/include/dt-bindings/pinctrl/pinctrl-tegra.h

> +/* Pull up/down/normal */
> +#define TEGRA_PIN_PUPD_NORMAL				0
> +#define TEGRA_PIN_PUPD_PULL_DOWN			1
> +#define TEGRA_PIN_PUPD_PULL_UP				2

... and s/NORMAL/NONE/ here too, I think. Some people might consider
some other value e.g. pull-up as normal:-)
