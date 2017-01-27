From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Jan 2017 11:01:54 +0800
Subject: [PATCH 2/2] clk: sunxi-ng: a33: Set CLK_SET_RATE_PARENT for the
 GPU
In-Reply-To: <20170127001254.GR8801@codeaurora.org>
References: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
 <1914af84712092019181807ddb72adfc5b40c6f4.1485250845.git-series.maxime.ripard@free-electrons.com>
 <20170127001254.GR8801@codeaurora.org>
Message-ID: <CAGb2v65v2GnSoC-oQWjQjK5GL4zeBUCEMBq9KXLLhEFviK1OXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 8:12 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/24, Maxime Ripard wrote:
>> In order to achieve all the rates asked by the GPU, we might need to change
>> the parent frequency.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>

> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
