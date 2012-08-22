From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Aug 2012 14:46:19 -0600
Subject: [PATCH v2 8/9] ARM: mvebu: Add pinctrl support to Armada 370 SoC
In-Reply-To: <1345623750-10645-9-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345623750-10645-9-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5035451B.3020708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2012 02:22 AM, Sebastian Hesselbarth wrote:
> This commits adds the necessary device tree information to define the
> compatible property for the pinctrl driver instance of Armada 370 SoC.

> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi

> +
> +                pinctrl at d0018000 {
> +			        compatible = "marvell,mv88f6710-pinctrl";
> +	        };

The indentation here is a mix of spaces and TABs.
