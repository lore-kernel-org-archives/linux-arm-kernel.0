From: andrea.adami@gmail.com (Andrea Adami)
Date: Wed, 2 Oct 2013 22:47:41 +0200
Subject: [PATCH] ARM: h3600: update defconfig
In-Reply-To: <20131002203219.GV12758@n2100.arm.linux.org.uk>
References: <1380532794-17277-1-git-send-email-linus.walleij@linaro.org>
 <20131002203219.GV12758@n2100.arm.linux.org.uk>
Message-ID: <CAAQYJAtWf9UYW3Zxmd+4gW-8aPtWyT0kNqCfRO5MNT_5ig4qCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 2, 2013 at 10:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 30, 2013 at 11:19:54AM +0200, Linus Walleij wrote:
>> This updates the h3600 defconfig against the latest kernel with
>> some small options coming and going due to Kconfig structure,
>> then modernize it to:
>>
>> - Use EABI to compile the kernel
>
> EABI on ARMv4 *non-T* and without --fix-v4bx (a) added to the linker
> arguments, and (b) V4BX relocations added to the kernel module loader?
> Are you sure this is all that's required?
>

Yes, the toolchain built with OpenEmbedded / Yocto Project contains
the necessary fixes [1] since end 2012.
Runtime tested eglibc and klibc on Zaurus collie.
Same binaries even tested on armv5te.

[1] http://cgit.openembedded.org/openembedded-core/log/?qt=grep&q=armv4

Cheers
Andrea

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
