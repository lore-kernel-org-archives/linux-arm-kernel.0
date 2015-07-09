From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 9 Jul 2015 16:02:45 +0530
Subject: [PATCH v6 2/4] dt-bindings: mediatek: Add MT8173 cpufreq driver
 bindings
In-Reply-To: <1436437661-17606-3-git-send-email-pi-cheng.chen@linaro.org>
References: <1436437661-17606-1-git-send-email-pi-cheng.chen@linaro.org>
 <1436437661-17606-3-git-send-email-pi-cheng.chen@linaro.org>
Message-ID: <20150709103245.GB5627@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-07-15, 18:27, Pi-Cheng Chen wrote:
> This patch adds device tree binding document for MT8173 cpufreq driver.
> The clock and regulator consumer properties are documented in
> Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt and
> referenced by this document.
> 
> Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mt8173.txt | 134 +++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mt8173.txt

NAK.

There are no new bindings in this file as you have moved them to
clock. And so this patch isn't required anymore.

-- 
viresh
