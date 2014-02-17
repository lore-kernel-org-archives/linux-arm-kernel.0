From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 17 Feb 2014 14:01:24 +0530
Subject: [PATCH 1/2] mfd: palmas: support IRQ inversion at the board level
In-Reply-To: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
References: <1392415108-4365-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5301C8DC.6040304@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 15 February 2014 03:28 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
>
> Some boards or SoCs have an inverter between the PMIC IRQ output pin and
> the IRQ controller input signal.
>
> The IRQ specifier in DT is meant to represent the IRQ flags at the input
> to the IRQ controller.
>

Looks good to me.
Acked-by: Laxman Dewangan <ldewangan@nvidia.com>
