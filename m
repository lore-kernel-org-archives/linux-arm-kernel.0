From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 12 Mar 2018 11:24:15 +0530
Subject: [Freedreno] [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180309174246.GD10589@jcrouse-lnx.qualcomm.com>
References: <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
 <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
 <20180307050624.GR23018@vireshk-i7>
 <20180308201438.GA10589@jcrouse-lnx.qualcomm.com>
 <20180309034332.GO6842@vireshk-i7>
 <20180309160355.GC10589@jcrouse-lnx.qualcomm.com>
 <152061592175.13890.6455929815877326231@swboyd.mtv.corp.google.com>
 <20180309174246.GD10589@jcrouse-lnx.qualcomm.com>
Message-ID: <20180312055415.GZ6842@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-03-18, 10:42, Jordan Crouse wrote:
> On Fri, Mar 09, 2018 at 09:18:41AM -0800, Stephen Boyd wrote:
> > BTW, it's qcom,corner and not qcom-corner right?
> 
> http://git.linaro.org/people/viresh.kumar/mylinux.git/commit/?h=opp/genpd/qcom&id=7586600b3bf3f8e79ce9198922fad7d4aa5b3f8d
> 
> +					qcom-corner = <1>;
> 
> shrug?

My branch isn't final and this naming has to come from Qcom (Rajendra). So it
can be qcom,corner eventually :)

-- 
viresh
