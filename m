From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 11 Dec 2017 13:27:19 +0530
Subject: [PATCH v1 4/4] arm64: dts: mediatek: add mt2712 cpufreq related
 device nodes
In-Reply-To: <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-5-git-send-email-andrew-sh.cheng@mediatek.com>
Message-ID: <20171211075719.GD25177@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> Add opp v2 information,
> and also add clocks, regulators and opp information into cpu nodes
> 
> Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 27 ++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi   | 57 +++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
