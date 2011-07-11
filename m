From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 11 Jul 2011 12:56:14 +0800
Subject: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
In-Reply-To: <201107110030.06399.vapier@gentoo.org>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711035732.GA5040@opensource.wolfsonmicro.com>
	<201107110030.06399.vapier@gentoo.org>
Message-ID: <CAGsJ_4x_e0OR8dV=n-zodi8Sr4SZkU6o6gJK13UpZrgTzZQvbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/11 Mike Frysinger <vapier@gentoo.org>:
> On Sunday, July 10, 2011 23:57:40 Mark Brown wrote:
>> On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
>>
>> Linus, CCing you in as apparently you're taking over the clock API work.
>> Do you need me to forward all the patches to you?
>
> along these lines, i dont think the new people on the cc noticed my earlier e-
> mail:
> for future series, could you cc uclinux-dist-devel at blackfin.uclinux.org ? ?we
> dont do clock management on Blackfin parts atm, but it's something we would
> like to start doing. ?our hardware can easily benefit from this.

Except that, AFAIK, arch/blackfin/mach-xxx is much similar with
arch/arm/mach-xxx with a lot of platform, i2c, spi board information.
it is probably we can also benefit from device tree as what ARM is
doing.
but not sure whether it is really worthwhile for the current situation
and long term plan of blackfin. Anyway, there are not so many blackfin
SoC and boards as ARM.

> -mike
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
