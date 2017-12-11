From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 11 Dec 2017 06:16:41 -0800
Subject: Linux kernel configuration for MPS2 AN385
In-Reply-To: <7575e032-2bd3-e894-d356-c2fc2c969ed4@arm.com>
References: <e529f3cb-da35-269c-83e3-bc07816904b9@roeck-us.net>
 <7575e032-2bd3-e894-d356-c2fc2c969ed4@arm.com>
Message-ID: <95d2267d-7a6d-fe1b-36f4-b68653d1f1eb@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2017 01:43 AM, Vladimir Murzin wrote:
> On 09/12/17 18:33, Guenter Roeck wrote:
>> Hi folks,
>>
>> I am playing with qemu's mps2-an385 emulation and try to get Linux to boot with it,
>> so far with little (ie no) success.
>>
>> Is a working kernel configuration for this board available somewhere ?
> 
> make ARCH=arm mps2_defconfig
> 
> would give you an Image and mps2-an385.dtb suitable for AN385.
> 
Yes, I got that far ...

> You also need a simple wrapper to pass control to kernel... I think
> you can get some clue from [1] as well.

... but I was missing that part. Thanks a lot!

Guenter

> 
> [1] https://community.arm.com/dev-platforms/b/documents/posts/instructions-for-running-uclinux-on-arm-s-mps2-platform
> 
> Cheers
> Vladimir
> 
>>
>> Thanks,
>> Guenter
>>
> 
> 
