From: gnurou@gmail.com (Alexandre Courbot)
Date: Fri, 16 Sep 2016 17:19:50 +0900
Subject: [PATCH] arm64: tegra: Add missing Smaug revision
In-Reply-To: <CAL1qeaF+Zck_p_1d-cNMvoJ8oMn7c65wL21E6LjGVVMA3BY2yA@mail.gmail.com>
References: <20160629085229.31350-1-acourbot@nvidia.com>
 <CAL1qeaF+Zck_p_1d-cNMvoJ8oMn7c65wL21E6LjGVVMA3BY2yA@mail.gmail.com>
Message-ID: <CAAVeFuLJmq5TCjd1QzvQnMikq2Us-6vv7D2CFn5ZrFnv38XXpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not seeing this patch in -next, can someone pick it?

On Fri, Jul 1, 2016 at 1:15 AM, Andrew Bresticker <abrestic@chromium.org> wrote:
> On Wed, Jun 29, 2016 at 1:52 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>> The "google,smaug-rev2" string is missing from the compatible list of
>> Smaug's DT. The differences of rev2 are not relevant at our current
>> level of support and it boots just fine, so add it.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>
> Acked-by: Andrew Bresticker <abrestic@chromium.org>
>
>> ---
>>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> index 431266a48e9c..82a96bd27bc8 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
>> @@ -11,7 +11,8 @@
>>         compatible = "google,smaug-rev8", "google,smaug-rev7",
>>                      "google,smaug-rev6", "google,smaug-rev5",
>>                      "google,smaug-rev4", "google,smaug-rev3",
>> -                    "google,smaug-rev1", "google,smaug", "nvidia,tegra210";
>> +                    "google,smaug-rev2", "google,smaug-rev1",
>> +                    "google,smaug", "nvidia,tegra210";
>>
>>         aliases {
>>                 serial0 = &uarta;
>> --
>> 2.9.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
