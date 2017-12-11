From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 11 Dec 2017 09:43:21 +0000
Subject: Linux kernel configuration for MPS2 AN385
In-Reply-To: <e529f3cb-da35-269c-83e3-bc07816904b9@roeck-us.net>
References: <e529f3cb-da35-269c-83e3-bc07816904b9@roeck-us.net>
Message-ID: <7575e032-2bd3-e894-d356-c2fc2c969ed4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/17 18:33, Guenter Roeck wrote:
> Hi folks,
> 
> I am playing with qemu's mps2-an385 emulation and try to get Linux to boot with it,
> so far with little (ie no) success.
> 
> Is a working kernel configuration for this board available somewhere ?

make ARCH=arm mps2_defconfig

would give you an Image and mps2-an385.dtb suitable for AN385.

You also need a simple wrapper to pass control to kernel... I think
you can get some clue from [1] as well.

[1] https://community.arm.com/dev-platforms/b/documents/posts/instructions-for-running-uclinux-on-arm-s-mps2-platform

Cheers
Vladimir

> 
> Thanks,
> Guenter
> 
