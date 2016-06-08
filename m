From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 08 Jun 2016 17:47:38 +0200
Subject: [PATCH v10 0/8] add i2c driver supported for rk3399
In-Reply-To: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
References: <1463407063-41218-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <2239664.BKqQWGCl8U@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Am Montag, 16. Mai 2016, 21:57:35 schrieb David Wu:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399

this series looks pretty nice now and it seems most everybody is happy with it 
by now. Do you still have it in your inbox to look at, or should David resend 
it again?


Heiko

> David Wu (8):
>   i2c: rk3x: add documentation to fields in "struct rk3x_i2c"
>   i2c: rk3x: use struct "rk3x_i2c_calced_timings"
>   i2c: rk3x: Remove redundant rk3x_i2c_clean_ipd()
>   i2c: rk3x: Change SoC data to not use array
>   i2c: rk3x: Move spec timing data to "static const" structs
>   dt-bindings: i2c: rk3x: add support for rk3399
>   i2c: rk3x: add i2c support for rk3399 soc
>   i2c: rk3x: support fast-mode plus for rk3399
> 
>  Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  16 +-
>  drivers/i2c/busses/i2c-rk3x.c                      | 498
> +++++++++++++++++---- 2 files changed, 434 insertions(+), 80 deletions(-)
