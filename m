From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Feb 2015 11:02:06 -0800
Subject: [PATCH 0/3] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <CANMBJr685FzZzQ660Z1aNJX+Kzkw1OqM6RJAviARbL+5a=MJ2A@mail.gmail.com>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <CANMBJr685FzZzQ660Z1aNJX+Kzkw1OqM6RJAviARbL+5a=MJ2A@mail.gmail.com>
Message-ID: <CAOesGMgjv9iLnLmpLADQYoAw=oUkJDAJs72Q5q=DQ75paQ+A-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 5, 2015 at 10:46 AM, Tyler Baker <tyler.baker@linaro.org> wrote:
> Hi Bintian,
>
> On 5 February 2015 at 01:24, Bintian Wang <bintian.wang@huawei.com> wrote:
>> Hello,
>>
>> Hi6220 is one mobile solution of Hisilicon, this patchset contains
>> initial support for Hi6220 SoC and HiKey development board, which
>> is based on ARM Cortex A53 architecture. Initial support is minimal
>> and includes just the arch configuration, clock driver, device tree
>> configuration.
>>
>> Many peripheral drivers will be submitted later.
>>
>> Any comments will be appreciated!
>>
>> Thanks,
>>
>> Bintian Wang (3):
>>   arm64: Enable Hisilicon ARMv8 SoC family in Kconfig and defconfig
>>   clk: hi6220: Clock driver support for Hisilicon hi6220 SoC
>>   arm64: dts: Add dts files for Hisilicon Hi6220 SoC
>
> Thanks for posting these! I've applied this series on top of
> next-20150204, however there was some fuzz that needed to be cleaned
> up on 3/3 [1]. I've confirmed the platform is booting to a basic user
> space without issue.

>From ramdisk only, right? Given the timing of the posting of this
patch set, I'm not going to merge it for 3.20. Hopefully for 3.21
there will be some more peripheral support as well -- at least some
sort of storage device.


-Olof
