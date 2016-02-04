From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 4 Feb 2016 08:53:53 +0530
Subject: Plain DFS (no voltage scaling)
In-Reply-To: <56B24634.6060001@free.fr>
References: <56B11B67.3090600@free.fr> <20160203021052.GK31828@vireshk>
 <56B21E2E.1070606@free.fr> <20160203161428.GJ3469@vireshk>
 <56B24634.6060001@free.fr>
Message-ID: <20160204032353.GQ3469@vireshk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-02-16, 19:25, Mason wrote:
> The sunxi guys pointed me in the right direction.
> 
> http://lxr.free-electrons.com/source/arch/arm/mach-sunxi/sunxi.c#L20
> 
> Why isn't there a compatible string like other drivers?
> 
> Such as
>   compatible = "cpufreq-dt"
> which would enable cpufreq on the platform?

Because DT can't have nodes for virtual devices :(

-- 
viresh
