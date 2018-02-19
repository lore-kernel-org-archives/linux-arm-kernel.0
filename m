From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 19 Feb 2018 09:08:33 +0530
Subject: [PATCH v3 06/15] arm64: dts: mt7622: add cpufreq related device
 nodes
In-Reply-To: <2cf761c2a20a8ff8a9208ddf3872f10f6f3198f5.1518895232.git.sean.wang@mediatek.com>
References: <cover.1518895232.git.sean.wang@mediatek.com>
 <2cf761c2a20a8ff8a9208ddf3872f10f6f3198f5.1518895232.git.sean.wang@mediatek.com>
Message-ID: <20180219033833.GG28462@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-02-18, 03:54, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add clocks, regulators and opp information into cpu nodes.
> In addition, the power supply for cpu nodes is deployed on
> mt7622-rfb1 board.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 12 +++++++
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 52 ++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
