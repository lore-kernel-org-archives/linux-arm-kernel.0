From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Feb 2018 17:26:56 -0600
Subject: [PATCH 09/10] dt-bindings: cpufreq-dt: Remove
 "cooling-{min|max}-level" properties
In-Reply-To: <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <aef1b506b365920d82b17c0712a3428196f72dc5.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <20180218232656.bjkomzkuv2my3ngy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 09, 2018 at 02:28:09PM +0530, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of kernel currently and the max cooling state of a
> CPU cooling device is found by referring to the cpufreq table instead.
> 
> Remove the unused bindings.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt | 4 ----
>  1 file changed, 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
