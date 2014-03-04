From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 04 Mar 2014 13:16:28 +0100
Subject: [PATCH v3 5/5] clk/exynos5260: add clock file for exynos5260
In-Reply-To: <5315C2CA.60206@gmail.com>
References: <1392724570-27977-1-git-send-email-rahul.sharma@samsung.com>	<1392724570-27977-6-git-send-email-rahul.sharma@samsung.com>	<53095A9A.4080606@gmail.com>
 <CAPdUM4PL9p-fNaim_YFFMV_bA4higxQa6ppSNUGg5nmMc7a6Mw@mail.gmail.com>
 <5315C2CA.60206@gmail.com>
Message-ID: <5315C41C.1030200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.03.2014 13:10, Tomasz Figa wrote:
> On 04.03.2014 05:14, Rahul Sharma wrote:
>> On 23 February 2014 07:49, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>> On 18.02.2014 12:56, Rahul Sharma wrote:
>>>> +       FRATE(ID_NONE, "phyclk_hdmi_link_o_tmds_clkhi", NULL,
>>>> +                       CLK_IS_ROOT, 125000000),
>>>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_txbyteclkhs", NULL,
>>>> +                       CLK_IS_ROOT, 187500000),
>>>> +       FRATE(ID_NONE, "phyclk_dptx_phy_o_ref_clk_24m", NULL,
>>>> +                       CLK_IS_ROOT, 24000000),
>>>> +       FRATE(ID_NONE, "phyclk_dptx_phy_clk_div2", NULL,
>>>> +                       CLK_IS_ROOT, 135000000),
>>>> +       FRATE(ID_NONE, "phyclk_mipi_dphy_4l_m_rxclkesc0", NULL,
>>>> +                       CLK_IS_ROOT, 20000000),
>>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_phyclock", NULL,
>>>> +                       CLK_IS_ROOT, 60000000),
>>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_freeclk", NULL,
>>>> +                       CLK_IS_ROOT, 60000000),
>>>> +       FRATE(ID_NONE, "phyclk_usbhost20_phy_clk48mohci", NULL,
>>>> +                       CLK_IS_ROOT, 48000000),
>>>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_pipe_pclk", NULL,
>>>> +                       CLK_IS_ROOT, 125000000),
>>>> +       FRATE(ID_NONE, "phyclk_usbdrd30_udrd30_phyclock", NULL,
>>>> +                       CLK_IS_ROOT, 60000000),
>>>
>>>
>>> Are these really fixed rate clocks? It looks strange, because it's a bit
>>> unlike previous Samsung SoCs, which used to have up 5 fixed rate
>>> clocks in
>>> average.
>>>
>>
>> These are outputs of various phys. If these are removed we will be
>> left with
>> many orphan clocks.
>>
>
> OK. Just wanted to make sure that they are real clocks found in the SoC,
> as I don't have access to Exynos 5420 datasheet yet.

Exynos 5260 of course.

Best regards,
Tomasz
