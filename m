From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 17:52:07 -0700
Subject: [PATCH V4 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d734a94af2263285fe8cef9f177212f15f218944.1430394884.git.viresh.kumar@linaro.org>
Message-ID: <20150520005207.GQ31753@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30, Viresh Kumar wrote:
> On some platforms (Like Qualcomm's SoCs), it is not decided until
> runtime on what OPPs to use. The OPP tables can be fixed at compile
> time, but which table to use is found out only after reading some efuses
> (sort of an eeprom) and knowing characteristics of the SoC.
> 
> To support such platform we need to pass multiple OPP tables per device
> and hardware should be able to choose one and only one table out of
> those.
> 
> Update OPP-v2 bindings to support that.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
