From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 16 Dec 2015 20:12:24 +0100
Subject: [PATCH] ARM: at91/dt: Add Support for the L+G VInCo platform
In-Reply-To: <1450292134-1640-1-git-send-email-gregory.clement@free-electrons.com>
References: <1450292134-1640-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151216191224.GG8574@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 16/12/2015 at 19:55:34 +0100, Gregory CLEMENT wrote :
> +			i2c2: i2c at f8024000 {
> +				status = "okay";
> +
> +				rtc1: rtc at 64 {
> +					compatible = "rx8900";

This should be epson,rx8900

> +					reg = <0x32>;
> +				};
> +			};
> +

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
