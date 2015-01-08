From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Jan 2015 13:47:44 +0100
Subject: [PATCH v2 8/8] ARM: mvebu: Add Armada 385 General Purpose
 Development Board support
In-Reply-To: <1420714305-7496-9-git-send-email-gregory.clement@free-electrons.com>
References: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
 <1420714305-7496-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150108124744.GA24268@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 11:51:45AM +0100, Gregory CLEMENT wrote:

> +		gpio-fan {
> +			compatible = "gpio-fan";
> +			gpios = <&expander1 3 GPIO_ACTIVE_HIGH>;
> +			gpio-fan,speed-map = <	 0 0
> +								  3000 1>;
> +		};
> +	};

Hi Gregory

The indentation is a bit off here. If there are no other comments, i
can fix it as i add it to mvebu/dt.

    Andrew
