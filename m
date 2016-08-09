From: robh@kernel.org (Rob Herring)
Date: Tue, 9 Aug 2016 18:55:37 -0500
Subject: [PATCH v3 02/15] dt/bindings: Update binding for PM domain idle
 states
In-Reply-To: <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
References: <1470351902-43103-1-git-send-email-lina.iyer@linaro.org>
 <1470351902-43103-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160809235537.GA28122@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 05:04:49PM -0600, Lina Iyer wrote:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
> 
> Update DT bindings to describe idle states of PM domains.
> 
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> [Lina: Added state properties, removed state names, wakeup-latency,
> added of_pm_genpd_init() API, pruned commit text]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> [Ulf: Moved around code to make it compile properly, rebased on top of multiple state support]

This change doesn't make sense given this is just a binding doc.

> ---
>  .../devicetree/bindings/power/power_domain.txt     | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
