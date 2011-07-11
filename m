From: vapier@gentoo.org (Mike Frysinger)
Date: Mon, 11 Jul 2011 01:01:56 -0400
Subject: [uclinux-dist-devel] [PATCH 0/6] clk: Initial feedback for
	off-SoC slow bus clocks
In-Reply-To: <CAGsJ_4x_e0OR8dV=n-zodi8Sr4SZkU6o6gJK13UpZrgTzZQvbQ@mail.gmail.com>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711035732.GA5040@opensource.wolfsonmicro.com>
	<201107110030.06399.vapier@gentoo.org>
	<CAGsJ_4x_e0OR8dV=n-zodi8Sr4SZkU6o6gJK13UpZrgTzZQvbQ@mail.gmail.com>
Message-ID: <CAMjpGUc51mg1vnj2PDk-=u=s7b0j0Qqm4nXLbugM5QsbshOZpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 00:56, Barry Song wrote:
> 2011/7/11 Mike Frysinger:
>> On Sunday, July 10, 2011 23:57:40 Mark Brown wrote:
>>> On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
>>> Linus, CCing you in as apparently you're taking over the clock API work.
>>> Do you need me to forward all the patches to you?
>>
>> along these lines, i dont think the new people on the cc noticed my earlier e-
>> mail:
>> for future series, could you cc uclinux-dist-devel at blackfin.uclinux.org ? ?we
>> dont do clock management on Blackfin parts atm, but it's something we would
>> like to start doing. ?our hardware can easily benefit from this.
>
> Except that, AFAIK, arch/blackfin/mach-xxx is much similar with
> arch/arm/mach-xxx with a lot of platform, i2c, spi board information.
> it is probably we can also benefit from device tree as what ARM is
> doing.

i dont think device trees are a requirement for the clock api

> but not sure whether it is really worthwhile for the current situation
> and long term plan of blackfin. Anyway, there are not so many blackfin
> SoC and boards as ARM.

there are not plans for device tree support.  no customers have asked
for it, and we arent in the arm situation where we have a distro (like
Ubuntu) riding us to have a single build boot on all the different
platforms.
-mike
