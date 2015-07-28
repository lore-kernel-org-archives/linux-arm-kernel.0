From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 28 Jul 2015 14:05:13 +0530
Subject: [PATCH v4 1/2] dt: cpufreq: st: Provide bindings for ST's
 CPUFreq implementation
In-Reply-To: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150728083513.GA26276@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-07-15, 16:20, Lee Jones wrote:
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> 
> Changelog:
>  - Using OPP-v2
>  - Moved (and linked) a bunch of documentation to ../power/
> 
>  .../devicetree/bindings/cpufreq/cpufreq-st.txt     | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt

For both patches:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

But I would like Rob to have a look as well :)
-- 
viresh
