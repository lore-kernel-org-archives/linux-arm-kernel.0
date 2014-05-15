From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Thu, 15 May 2014 10:55:40 +0530
Subject: [PATCH v4 2/5] ARM: dts: change to correct compatible string for
 exynos5420 hdmi
In-Reply-To: <5373C7B7.5000300@gmail.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-3-git-send-email-rahul.sharma@samsung.com>
 <5373C7B7.5000300@gmail.com>
Message-ID: <CAPdUM4PS4OH7ocqVsxkjohKFKXENVOp3L8L72HP+bSDv_5gWuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Tomasz,

Patch which add this compatible in documentation is available at
http://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/log/?h=exynos-drm-next

Regards,
Rahul Sharma

On 15 May 2014 01:14, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Rahul,
>
> On 14.05.2014 04:45, Rahul Sharma wrote:
>> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>>
>> Replace compatible string for HDMI node in Exynos5420. Since
>> latest restructring in Drm hdmi driver, it is agreed to use
>> a seperate compatible string for Exynos5420 HDMI IP siince it
>> uses APB mapped Phy.
>>
>> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
>> ---
>>  arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
>> index a802f74..016992c 100644
>> --- a/arch/arm/boot/dts/exynos5420.dtsi
>> +++ b/arch/arm/boot/dts/exynos5420.dtsi
>> @@ -640,7 +640,7 @@
>>       };
>>
>>       hdmi: hdmi at 14530000 {
>> -             compatible = "samsung,exynos4212-hdmi";
>> +             compatible = "samsung,exynos5420-hdmi";
>>               reg = <0x14530000 0x70000>;
>>               interrupts = <0 95 0>;
>>               clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
>>
>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
>
> The compatible string doesn't seem to be documented in linux-next,
> though. Are the necessary patches adding it already merged?
>
> Best regards,
> Tomasz
