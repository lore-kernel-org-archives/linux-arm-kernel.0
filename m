From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 3 Nov 2016 13:45:55 +0000
Subject: [PATCH V3 2/6] clk: tegra: add TEGRA30_CLK_NOR to init table
In-Reply-To: <1477576872-2665-3-git-send-email-mirza.krak@gmail.com>
References: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
 <1477576872-2665-3-git-send-email-mirza.krak@gmail.com>
Message-ID: <cf378096-26ca-33d2-2b51-a388aa080b3b@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 27/10/16 15:01, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
>
> Add TEGRA30_CLK_NOR to init table and set default rate to 127 MHz which
> is max rate.
>
> The maximum rate value of 127 MHz is pulled from the downstream L4T
> kernel.
>
> Signed-off-by: Mirza Krak <mirza.krak@gmail.com>
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Tested-on: Colibri T20/T30 on EvalBoard V3.x and GMI-Memory Board

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
