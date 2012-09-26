From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Thu, 27 Sep 2012 00:24:11 +0530
Subject: [PATCH 07/10] ARM: msm: Remove clock-7x30.h include file
In-Reply-To: <506346ED.3020900@codeaurora.org>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-8-git-send-email-sboyd@codeaurora.org>
 <CADTbHxqrPmnOHqqYyskC32bN269k-_pgk-+czwf7zLCs70ESzA@mail.gmail.com>
 <506346ED.3020900@codeaurora.org>
Message-ID: <CADTbHxrRBg8GnciN2SyzBrQrc2Y3aXmJKbT7SZq8-QMfw4vgoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 26, 2012 at 11:48 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/26/12 10:51, Pankaj Jangra wrote:
>> On Fri, Sep 21, 2012 at 7:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
>>> index 09b4f14..1597d43 100644
>>> --- a/arch/arm/mach-msm/devices-msm7x30.c
>>> +++ b/arch/arm/mach-msm/devices-msm7x30.c
>>> @@ -146,7 +146,6 @@ struct clk_lookup msm_clocks_7x30[] = {
>>>         CLK_PCOM("grp_2d_pclk", GRP_2D_P_CLK,   NULL, 0),
>>>         CLK_PCOM("grp_clk",     GRP_3D_CLK,     NULL, 0),
>>>         CLK_PCOM("grp_pclk",    GRP_3D_P_CLK,   NULL, 0),
>>> -       CLK_7X30S("grp_src_clk", GRP_3D_SRC_CLK, GRP_3D_CLK,    NULL, 0),
>>>         CLK_PCOM("hdmi_clk",    HDMI_CLK,       NULL, 0),
>>>         CLK_PCOM("imem_clk",    IMEM_CLK,       NULL, OFF),
>> I suppose you forget to remove the include header clock-7x30.h from
>> this file. :)
>
> Thanks, fixed. BTW, you could have trimmed this mail down so I didn't
> have to scroll to the bottom.
>
ah, i think mistakenly i forgot. Next time will keep in mind..:)

--
Pankaj Jangra
