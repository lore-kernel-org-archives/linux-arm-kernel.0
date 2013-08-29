From: r.sh.open@gmail.com (Rahul Sharma)
Date: Thu, 29 Aug 2013 19:06:51 +0530
Subject: [PATCH v4 0/5] clk/exynos5420: add clocks for hdmi subsystem
In-Reply-To: <1873021.WMcNDqLpjt@amdc1227>
References: <1377754629-31465-1-git-send-email-rahul.sharma@samsung.com>
 <1873021.WMcNDqLpjt@amdc1227>
Message-ID: <CAPdUM4Mf4pv031-W0X0EAJe7R=8xtqnNbbLyoo+O6LV0d-H0GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 August 2013 18:00, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Rahul,
>
> On Thursday 29 of August 2013 11:07:04 Rahul Sharma wrote:
>> Add clock changes for hdmi subsystem for exynos5250 SoC. These
>> include addition of new clocks like mout_hdmi and smmu_tv, associating
>> ID to clk_hdmiphy and some essential corrections.
>>
>> V4:
>> 1) Optimised gaps between Gate, Muxes and Dividers.
>>
>> V3:
>> 1) Assign new ID to divider clock keeping sclk_pixel gate same.
>>
>> V2:
>> 1) Rebase to Mike's Tree.
>> 2) Change smmu_tv to smmu_mixer.
>>
>> This set is based on Mike's clk-next branch at
>> https://git.linaro.org/gitweb?p=people/mturquette/linux.git
>>
>> Rahul Sharma (5):
>>   clk/exynos5420: add sclk_hdmiphy to the list of special clocks
>>   clk/exynos5420: add gate clock for mixer sysmmu
>>   clk/exynos5420: fix the order of parents of hdmi mux
>>   clk/exynos5420: add hdmi mux to change parents in hdmi driver
>>   clk/exynos5420: assign dout_pixel id to pixel clock divider
>>
>>  .../devicetree/bindings/clock/exynos5420-clock.txt  |   12 ++++++++++++
>>  drivers/clk/samsung/clk-exynos5420.c                |   19
>> +++++++++++++------ 2 files changed, 25 insertions(+), 6 deletions(-)
>
> For the whole series:
>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
>

Thanks Tomasz,

Mike ! please consider it for clk-next branch.

regards,
Rahul Sharma.

> Best regards,
> Tomasz
>
