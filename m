From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 29 Jun 2018 15:24:26 +0530
Subject: [PATCH 3/3] arm64: dts: marvell: armada-37xx: add the node
 allowing AVS support
In-Reply-To: <20180619124402.902-4-gregory.clement@bootlin.com>
References: <20180619124402.902-1-gregory.clement@bootlin.com>
 <20180619124402.902-4-gregory.clement@bootlin.com>
Message-ID: <20180629095426.7aein2vmjtegyrfa@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-06-18, 14:44, Gregory CLEMENT wrote:
> In order to be able to use Adaptive Voltage Scaling, we need to add a
> reference to these registers.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
