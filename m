From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 3 Nov 2016 10:06:27 +0000
Subject: [PATCH V3 1/6] clk: tegra: add TEGRA20_CLK_NOR to init table
In-Reply-To: <1477576872-2665-2-git-send-email-mirza.krak@gmail.com>
References: <1477576872-2665-1-git-send-email-mirza.krak@gmail.com>
 <1477576872-2665-2-git-send-email-mirza.krak@gmail.com>
Message-ID: <df12a1f0-316d-64a4-54fe-f7559742eeca@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mirza,

On 27/10/16 15:01, Mirza Krak wrote:
> From: Mirza Krak <mirza.krak@gmail.com>
>
> Add TEGRA20_CLK_NOR to init table and set default rate to 92 MHz which
> is max rate.
>
> The maximum rate value of 92 MHz is pulled from the downstream L4T
> kernel.

Thanks for adding this. I assume that this is from an L4T r16 release 
with a v3.1 kernel. I had a quick poke through the kernel sources for 
v3.1 but was unable to see where this is set. Obviously v3.1 did not 
have CCF and so everything seems to be in the arch/arm/mach-tegra 
directory for setting up clocks. Can you point me to the appropriate 
sources so I can ACK this?

Cheers
Jon

-- 
nvpublic
