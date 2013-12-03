From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 3 Dec 2013 11:34:13 +0530
Subject: [PATCH 1/2] ARM: dts: tegra: Header file for pinctrl constants
In-Reply-To: <20131202142522.GA17566@ulmo.nvidia.com>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
 <20131202142522.GA17566@ulmo.nvidia.com>
Message-ID: <529D745D.2070503@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 December 2013 07:55 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Mon, Dec 02, 2013 at 07:25:01PM +0530, Laxman Dewangan wrote:
>

> +
> +/* Schmitt enable/disable */
> +#define TEGRA_PIN_DRIVE_SCHMITT_DISABLE			0
> +#define TEGRA_PIN_DRIVE_SCHMITT_ENABLE			1
> These are all boolean, so I wonder if perhaps we should be simply
> defining a single pair and reuse that in different contexts:
>
> 	#define TEGRA_PIN_DISABLE	0
> 	#define TEGRA_PIN_ENABLE	1
>
> The property names should provide enough context for them to be used
> unambiguously.
>
>

I can make generic ENABLE/DISABLE macro as you suggested but datasheet 
says as 0=NORMAL, 1 = TRISTATE. and that's why I kept name very near to 
the datasheet.

Thanks,
Laxman
