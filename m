From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 07 Jan 2015 16:25:37 +0100
Subject: [PATCH v2 7/7] ARM: mvebu: Add Armada 385 Access Point Development
 Board support
In-Reply-To: <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
References: <1420558100-4700-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420558100-4700-8-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <54AD4FF1.8030508@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,
[..]

> +
> +			mdio at 72004 {
> +				pinctrl-names = <&mdio_pins>;
I guess it is a typo and you meant:

				pinctrl-names = "default;
				pinctrl-0 = <&mdio_pins>;


Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
