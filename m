From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 25 Feb 2016 15:23:18 +0100
Subject: [GIT PULL] ARM: mvebu: dt64 for v4.6 (#1)
In-Reply-To: <20160225005608.GB29055@localhost> (Olof Johansson's message of
 "Wed, 24 Feb 2016 16:56:08 -0800")
References: <877fi3s48z.fsf@free-electrons.com>
 <20160225005608.GB29055@localhost>
Message-ID: <87si0goomh.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,
 
 On jeu., f?vr. 25 2016, Olof Johansson <olof@lixom.net> wrote:

> On Wed, Feb 17, 2016 at 05:14:52PM +0100, Gregory CLEMENT wrote:
>> Hi,
>> 
>> Here is the first pull request for dt64 for mvebu for v4.6.
>> 
>> This is the second part of the Armada 3700 series[1]. This part is
>> easier to handle as there is no dependency. As for the other one, let me
>> know if I should do it in a different way.
>> 
>> Thanks,
>> 
>> Gregory
>> 
>> [1]: https://lkml.org/lkml/2016/2/16/735
>> 
>> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
>> 
>>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
>> 
>> are available in the git repository at:
>> 
>>   git://git.infradead.org/linux-mvebu.git tags/mvebu-dt64-4.6-1
>> 
>> for you to fetch changes up to adbc3695d9e487fa07214140a46b68ac3156fb78:
>> 
>>   arm64: dts: add the Marvell Armada 3700 family and a development board (2016-02-17 16:09:55 +0100)
>> 
>> ----------------------------------------------------------------
>> mvebu dt64 for 4.6 (part 1)
>> 
>> Device tree part of the Armada 3700 support:
>> - binding for the Armada 3700 SoCs
>> - device tree files for the SoCs and a board
>> - tidy up the Marvell related files
>> 
>> ----------------------------------------------------------------
>> Gregory CLEMENT (4):
>>       Documentation: dt-bindings: Add a new compatible for the Armada 3700
>>       Documentation: dt: Tidy up the Marvell related files
>>       devicetree: bindings: add DT binding for the Marvell Armada 3700 SoC family
>>       arm64: dts: add the Marvell Armada 3700 family and a development board
>
> Merged, thanks.
>
> In the future, please use arm64: dts: marvell: ...

OK, I will do it for the next PR.

Thanks,

Gregory

>
>
> -Olof
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
