From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 27 Jun 2017 16:15:20 +0100
Subject: [PATCH V3 0/5] arch_topology: Minor cleanups
In-Reply-To: <cover.1498209817.git.viresh.kumar@linaro.org>
References: <cover.1498209817.git.viresh.kumar@linaro.org>
Message-ID: <20170627151520.cgdvjcqsy6iocp2l@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On 23/06/17 14:55, Viresh Kumar wrote:
> Hi Greg,
> 
> You weren't included in the first [1] version of this series, as it was
> targeting arch/arm*/ directories then.
> 
> Here are some cleanups for the arch_topology core.
> 
> Tested on ARM64 Hikey board by setting following in cpu nodes in DT:
>         capacity-dmips-mhz = <1000>;
> 

The set looks ok to me. Also tested on JunoR2 and TC2.

You can add my

Reviewed-and-tested-by: Juri Lelli <juri.lelli@arm.com>

Best,

- Juri
