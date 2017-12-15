From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Dec 2017 15:50:41 +0000
Subject: [PATCH] arm64: defconfig: Select schedutil as default cpufreq
 governor
In-Reply-To: <af12e002bc165844101830c0eb00e283b536a879.1510813288.git.viresh.kumar@linaro.org>
References: <af12e002bc165844101830c0eb00e283b536a879.1510813288.git.viresh.kumar@linaro.org>
Message-ID: <20171215155040.mlvd56i2rfgd2e2t@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:51:36AM +0530, Viresh Kumar wrote:
> Currently performance governor is getting selected by default, which is
> surely not a very good choice as its pretty much power hungry.
> 
> Select schedutil instead.

And why do we care about this in defconfig? People deploying their own
kernels in mobile may opt for this config, others may prefer the default
governor.

Also it seems it would be the only architecture make this governor the
default, so NAK.

-- 
Catalin
