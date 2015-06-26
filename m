From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Jun 2015 10:34:01 +0100
Subject: [PATCH 3/4] arm64: dts: add Rockchip rk3368 core dtsi and board
 dts for the r88 board
In-Reply-To: <3220645.At1oVfRcjk@diego>
References: <1650408.ovnAjReNFJ@diego>
 <3220645.At1oVfRcjk@diego>
Message-ID: <20150626093400.GA19947@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +       memory {
> +               reg = <0x0 0x0 0x0 0x40000000>;
> +       };

This needs device_type = "memory", no?

I guess the bootloader is overriding this anyway?

Otherwise this looked fine to me.

Thanks,
Mark.
