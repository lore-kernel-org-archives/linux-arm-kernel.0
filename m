From: monstr@monstr.eu (Michal Simek)
Date: Wed, 30 Jan 2013 10:13:26 +0100
Subject: [GIT PULL v3] arm-soc: Xilinx zynq timer changes for v3.9
In-Reply-To: <20130130021159.GA13897@quad.lixom.net>
References: <CAHTX3d+qeKPT3YYG3=YgWYN5YTS1oT9HoTEpVwC4GZAYve5uYw@mail.gmail.com>
 <CAHTX3d+tDZF1-aKKfx+Zsb4FefrBbLaxe9qAz1Vsf3rDb-qHTw@mail.gmail.com>
 <20130130021159.GA13897@quad.lixom.net>
Message-ID: <CAHTX3dLQJfha9Cn3_w3D6q+bO3EQMHWDU-yr4SBFdRkda+eo_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/30 Olof Johansson <olof@lixom.net>:
> On Mon, Jan 28, 2013 at 01:53:11PM +0100, Michal Simek wrote:
>> Hi Olof,
>>
>> based on your previous email I am sending updated pull request which is based
>> on arm-soc depends/cleanup branch.
>> As I wrote in my email I tend to keep there Soren's patch around
>> renaming PSS to PS
>> and be more strict on this for future.
>> I have also added one more patch which fix Rob's conversion to irqchip_init.
>
> Ok, pulled. Sorry for the delay, I had forgotten this email halfway read on my
> machine at home, so it fell of my list of branches to pull earlier today.
>
>> btw: As I mentioned in the previous email I want to add 2 defconfig
>> updates + maintainer
>> fragment. I have created branch zynq/misc in the same repo. Is this
>> name ok for you?
>> If yes, I will send you separate pull request just for this branch.
>
> Ah, do'h, I replied to the previous email. Nevermind that suggestion then, I'll
> just pull the misc branch.

I just collection that patches just for sure not to be lost.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
