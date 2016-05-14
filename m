From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 May 2016 13:30:41 +0200
Subject: [PATCH v9 0/8] add i2c driver supported for rk3399
In-Reply-To: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
References: <1463039586-8134-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1649653.55gUf8lt1c@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Mai 2016, 15:52:58 schrieb David Wu:
> There are three points differert from others:
>  - new method to caculate i2c timings for rk3399
>  - pclk and function clk are separated at rk3399
>  - add fast-plus mode supported for rk3399

On a rk3288

Tested-by: Heiko Stuebner <heiko@sntech.de>

to make sure nothing currently working broke - and everything is running 
still fine.


Heiko
