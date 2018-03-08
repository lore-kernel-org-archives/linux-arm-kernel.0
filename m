From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 8 Mar 2018 10:28:26 +0530
Subject: [PATCH v2] arm64: dts: msm8916: Add cpu cooling maps
In-Reply-To: <CAP245DU-VO9S7jh9d8gZNgM6Hr29P=Uzi4kxb_T8QLqbuQwFig@mail.gmail.com>
References: <cover.1520398076.git.amit.kucheria@linaro.org>
 <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
 <4d134dee2154ae3fa56b375aaed9568e21b1a777.1520398076.git.amit.kucheria@linaro.org>
 <CAOh2x=k6aXd=pPaNKhd-fna58wk4mNcMWgy1Eb=VYwECRtqLaA@mail.gmail.com>
 <CAP245DU-VO9S7jh9d8gZNgM6Hr29P=Uzi4kxb_T8QLqbuQwFig@mail.gmail.com>
Message-ID: <20180308045826.GE6842@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07-03-18, 16:56, Amit Kucheria wrote:
> On Wed, Mar 7, 2018 at 10:44 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On Wed, Mar 7, 2018 at 10:30 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> >> From: Rajendra Nayak <rnayak@codeaurora.org>
> >>
> >> Add cpu cooling maps for cpu passive trip points. The cpu cooling
> >> device states are mapped to cpufreq based scaling frequencies.
> >>
> >> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> >> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> >> ---
> >>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> >> index e468277..66b318e 100644
> >> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> >> @@ -15,6 +15,7 @@
> >>  #include <dt-bindings/clock/qcom,gcc-msm8916.h>
> >>  #include <dt-bindings/reset/qcom,gcc-msm8916.h>
> >>  #include <dt-bindings/clock/qcom,rpmcc.h>
> >> +#include <dt-bindings/thermal/thermal.h>
> >>
> >>  / {
> >>         model = "Qualcomm Technologies, Inc. MSM8916";
> >> @@ -115,6 +116,7 @@
> >>                         cpu-idle-states = <&CPU_SPC>;
> >>                         clocks = <&apcs 0>;
> >>                         operating-points-v2 = <&cpu_opp_table>;
> >> +                       #cooling-cells = <2>;
> >
> > LGTM.
> 
> Can I take that as a Reviewed-by?

Sure.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
