From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 2 Jan 2010 22:45:24 +0800
Subject: Mach-Id query
In-Reply-To: <01895E84-95EF-4312-BF54-F393CF54FBE8@gmail.com>
References: <01895E84-95EF-4312-BF54-F393CF54FBE8@gmail.com>
Message-ID: <e68bb3471001020645j3836c210le284b88b19014632@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/30  <soumendra.satapathy@gmail.com>:
> Dear All,
> I am working a proprietary ARM development board.
> I have registered the machine ID for this @www.arm.linux.org.uk
> Now i addded this to mach-types file in arm/tools/mach-types file.

Why to add this?
Are you doing porting the proprietary ARM to Linux?

> Now before compiling i need to have the defualt config file which is
> found in the directory arch/arm/configs for variuos boards.
> How are these genarated for lets say omap_2430sdp_defconfig (this is a
> automatically generated file is what i can see) ??

The defconfig is not generated automatically.
You need to copy this to arch/arm/configs.

> All replies are humbly appreciated.
> regards,
> som
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
