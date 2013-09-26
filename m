From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 26 Sep 2013 12:04:17 -0300
Subject: [PATCH 2/5] ARM: mvebu: Add Core Divider clock device-tree binding
In-Reply-To: <20130926083655.GB18244@lunn.ch>
References: <1380144502-24109-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130925213730.GA19371@localhost> <20130926083655.GB18244@lunn.ch>
Message-ID: <20130926150416.GA4583@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 10:36:55AM +0200, Andrew Lunn wrote:
> Hi Ezequiel
> 
> +#define CORE_CLOCK_DIVIDER_RATIO_OFFSET		0x8
> ...
> 
> reg = readl(corediv->reg + CORE_CLOCK_DIVIDER_RATIO_OFFSET);
> 
> ...
> 
> +Example:
> +
> +corediv_clk: corediv-clocks at 18740 {
> +	      compatible = "marvell,armada-370-corediv-clock";
> +	      reg = <0x18740 0x8>;
> +	      #clock-cells = <1>;
> +	      clocks = <&pll>;
> +};
> 
> The reg property seems to be wrong.
> 

Mm.. good catch!

Thanks for the review,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
