From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 10 Jan 2017 09:22:32 +0800
Subject: [PATCH v2 2/2] clk: hisilicon: Add clock driver for hi3660 SoC
In-Reply-To: <20170110002224.GH17126@codeaurora.org>
References: <1482978805-6981-1-git-send-email-zhangfei.gao@linaro.org>
 <1482978805-6981-3-git-send-email-zhangfei.gao@linaro.org>
 <20170110002224.GH17126@codeaurora.org>
Message-ID: <83ecb313-2ad4-379b-6ae8-95d8b570a110@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017?01?10? 08:22, Stephen Boyd wrote:
> On 12/29, Zhangfei Gao wrote:
>> Add clock drivers for hi3660 SoC, this driver controls the SoC
>> registers to supply different clocks to different IPs in the SoC.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
> Applied to clk-hi3660 and merged into clk-next. I took the
> liberty of using a function pointer in probe though so we don't
> need the enum anymore.

Good idea. It is simplified a lot.
Have verified on hikey960.

Thanks Stephen for the help.
