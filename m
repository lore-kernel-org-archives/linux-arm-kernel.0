From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Apr 2012 12:06:40 +0000
Subject: [PATCH] ARM: at91: add kizbox board dt support.
In-Reply-To: <4F914F2D.70807@overkiz.com>
References: <4F914F2D.70807@overkiz.com>
Message-ID: <201204201206.41068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 April 2012, Boris BREZILLON wrote:
> +       i2c at 0 {
> +               status = "okay";
> +
> +               pcf8563 at 51 {
> +                       /* nxp pcf8563 rtc */
> +                       compatible = "pcf8563";
> +                       reg = <0x51>;
> +               };
> +
> +       };

Same comment that I gave about ethernut-5:

This should be compatible="nxp,pcf8563". Everything else looks good.

	Arnd
