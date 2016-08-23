From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 23 Aug 2016 18:15:15 +0200
Subject: [v.1] clk:clk-rockchip:-of_iomap failed to remap then abort clock
 initialization.
In-Reply-To: <1471101978-1881-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1471101978-1881-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1528160.BtdbmuP27T@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arvind,

Am Samstag, 13. August 2016, 20:56:18 schrieb Arvind Yadav:
> -check return of 'of_iomap'.if It's falied to remap then abort.
> 
> -Unmap a region obtained by remap. iounmap frees the mapping when failed
> to allocate the memory.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/clk/rockchip/clk-rockchip.c | 7 ++++++-

I've applied the patch, after rewording both patch subject and message [0].

That driver is deprecated for quite some time, see
Documenation/devicetree/bindings/clock/rockchip.txt - so I'm hoping this is
more of a random find and you're not actually using it?


Thanks
Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=023a8280b8355a0aebe094299afec8d8b7b264cd
