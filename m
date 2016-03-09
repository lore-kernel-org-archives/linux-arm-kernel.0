From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 9 Mar 2016 09:26:34 +0800
Subject: [RESEND PATCH v2 5/5] clk: rockchip: add clock controller for the
 RK3399
In-Reply-To: <56DF7393.4020600@rock-chips.com>
References: <1456827275-8035-1-git-send-email-zhengxing@rock-chips.com>
 <1456827322-8130-1-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=VhMY=YO7zVYeP-+LY0gPvQ8yjaAUEGVJrMGLwbGjqVmg@mail.gmail.com>
 <56DF7393.4020600@rock-chips.com>
Message-ID: <56DF7BCA.3000900@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,
     Yes, I will resend my patch series include the previous patches 
(header file and dt-bindings) of the Jianqun, and update the header file 
for the MMC defines.

Thanks.

On 2016?03?09? 08:51, Jianqun Xu wrote:
> Hi Doug:
>
> ? 09/03/2016 07:34, Doug Anderson ??:
>> Xing Zheng,
>>
>> On Tue, Mar 1, 2016 at 2:15 AM, Xing Zheng <zhengxing@rock-chips.com> 
>> wrote:
>>> +       MMC(SCLK_SDMMC_DRV, "emmc_drv",    "clk_sdmmc", 
>>> RK3399_SDMMC_CON0, 1),
>>> +       MMC(SCLK_SDMMC_SAMPLE,  "emmc_sample", "clk_sdmmc", 
>>> RK3399_SDMMC_CON1, 1),
>>
>> Can you and Jianqun Xu please coordinate?  Though I don't have a TRM
>> for rk3399 and I haven't looked through this whole patch, I know for
>> sure there's a problem when I pick the latest patch series from both
>> of you it doesn't compile.
>>
>> I believe this is the latest from each of you in patchwork:
>>
>> 8462411   [v3,1/3] dt-bindings: add bindings for rk3399 clock controller
>> 8462431   [v3,2/3] clk: rockchip: add dt-binding header for rk3399
>> 8462441   [v3,3/3] ARM64: dts: rockchip: add core dtsi file for rk3399
>>
>> 8463741   [RESEND,v2,1/5] clk: rockchip: add more mux parameters for
>> new pll sources
>> 8463801   [RESEND,v2,2/5] clk: rockchip: Add support for multiple
>> clock providers
>> 8463771   [RESEND,v2,3/5] clk: rockchip: add new pll-type for rk3399
>> and similar socs
>> 8463781   [RESEND,v2,4/5] clk: rockchip: add a 
>> COMPOSITE_FRACMUX_NOGATE type
>> 8463831   [RESEND,v2,5/5] clk: rockchip: add clock controller for the 
>> RK3399
>>
>>
>> Specifically your patch from March 1st refers to SCLK_SDMMC_DRV and
>> SCLK_SDMMC_SAMPLE.  Those defines existed in Jianqun Xu's patch back
>> on Feb 19th <https://patchwork.kernel.org/patch/8355411/>, but his
>> latest patch series from March 1st
>> <https://patchwork.kernel.org/patch/8462431/> no longer has those
>> #defines.
>>
>> Can you two resolve this so I can pick both patch series and see that
>> they compile?  ...or let me know where I messed up, of course.
>>
> ok, we will upload dtsi later after the clk-rk3399 driver been applied.
> xing will send the patches for rk3399 together.
>
> We hope the dtsi could be applied first but depends on clk driver, but 
> it seems
> not a good idea, we will resend dtsi patch after more drivers are 
> applied.
>
> Thanks Doug.
>
>> Thanks!
>>
>> -Doug
>>
>>
>>
>
>
>

-- 
- Xing Zheng
