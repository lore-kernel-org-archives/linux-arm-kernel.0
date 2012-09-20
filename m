From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 20 Sep 2012 10:15:47 +0530
Subject: [PATCH] ARM: dts: use uart2 for console on smdkv310 and smdk5250
In-Reply-To: <099701cd96bd$0e7a3dd0$2b6eb970$@org>
References: <052601cd94ca$058db4d0$10a91e70$%kim@samsung.com>
 <CAJuYYwQ0A9c_R=HzjeBCxL7E5bpw3j+64ApsCH5Uc8Q6i+HY4Q@mail.gmail.com>
 <099701cd96bd$0e7a3dd0$2b6eb970$@org>
Message-ID: <CAJuYYwQTYw69wrJZJ7q6pWzmAEx+dLe0sRZk29eZ=nuyzB+-BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 September 2012 04:48, Kukjin Kim <kgene@kernel.org> wrote:
> Thomas Abraham wrote:
>>
>> On 17 September 2012 17:16, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> >
>> > Cc: Thomas Abraham <thomas.abraham@linaro.org>
>> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>> > ---
>> >  arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
>> >  arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 +-
>> >  2 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts
>> b/arch/arm/boot/dts/exynos4210-smdkv310.dts
>> > index 1beccc8..cb01e3d 100644
>> > --- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
>> > +++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
>> > @@ -26,7 +26,7 @@
>> >         };
>> >
>> >         chosen {
>> > -               bootargs = "root=/dev/ram0 rw ramdisk=8192
>> initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc";
>> > +               bootargs = "root=/dev/ram0 rw ramdisk=8192
>> initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
>> >         };
>>
>> Dear Mr. Kim,
>>
>> What is the reason for changing the console port to 2 for smdkv310 board?
>>
> Since uart1 can be used for other purpose, we changed the default console
> port to use uart2 a few month ago for all of SMDKs. And if required, I will
> change it for current defconfigs.

Ok, thanks for the information.

Regards,
Thomas.
