From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 07 Oct 2013 11:20:47 -0600
Subject: [PATCH 5/7] ARM: tegra: add Venice2 board support
In-Reply-To: <1381131085-26116-6-git-send-email-josephl@nvidia.com>
References: <1381131085-26116-1-git-send-email-josephl@nvidia.com>
 <1381131085-26116-6-git-send-email-josephl@nvidia.com>
Message-ID: <5252ED6F.9070303@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2013 01:31 AM, Joseph Lo wrote:
> Add support for the Tegra124 based Venice2 reference board.

> diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts

> +	pmc {

You'll need to update the node name here too.

> +		nvidia,invert-interrupt;
> +	};
> +
> +};

There's an extra blank line between the two }; above.
