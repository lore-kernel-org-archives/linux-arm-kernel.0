From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 12 Jul 2018 23:54:35 +0200
Subject: [PATCH v2 4/6] arm: dts: add support for Laird WB50N cpu module
 and DVK
In-Reply-To: <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
References: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
 <1529070055-18701-4-git-send-email-ben.whitten@lairdtech.com>
Message-ID: <20180712215435.GL16084@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've now applied the whole series after fixing two small whitespace
issues.

On 15/06/2018 14:40:53+0100, Ben Whitten wrote:
> +&usart1_clk {
> +	atmel,clk-output-range = <0 132000000>;
> +};
> +

But this is not actually allowed by the hardware (well, it is but it
will lead to issues) and will be removed once the clock binding is
reworked.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
