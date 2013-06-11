From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 11 Jun 2013 18:53:11 +0530
Subject: [PATCH 09/13] clk: exynos5420: register clocks using common clock
 framework
In-Reply-To: <CANruHrT_AVaQ0KAVkt6U0oS2_sz=2vmZn7KitNbQk96u7F4CSw@mail.gmail.com>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
 <1370516488-25860-9-git-send-email-chander.kashyap@linaro.org>
 <CANruHrT_AVaQ0KAVkt6U0oS2_sz=2vmZn7KitNbQk96u7F4CSw@mail.gmail.com>
Message-ID: <CANuQgHG2DK=w_=w4jftRtBEswAtLEeSj9_-aFXMM=RtFNa92ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 June 2013 16:42, sunil joshi <sjoshi.open@gmail.com> wrote:
> Hi Chander,
>
> [snip]
>
>> +  sclk_uart3           131
>> +  sclk_mmc0            132
>> +  sclk_mmc1            132
oops, i will fix. thanks
>> +  sclk_mmc2            133
>
> above 2 numbers got repeated. Doug had found this in chromium tree and
> fixed it. [ https://gerrit.chromium.org/gerrit/#/c/56626/]
>
> Pls fix the typo in next version.
>
> Regards
> Sunil



--
with warm regards,
Chander Kashyap
