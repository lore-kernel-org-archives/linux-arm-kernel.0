From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Mar 2018 17:25:11 -0500
Subject: [PATCH v4 1/5] dt-bindings: gpio: Add a gpio-reserved-ranges
 property
In-Reply-To: <20180323163453.96495-2-swboyd@chromium.org>
References: <20180323163453.96495-1-swboyd@chromium.org>
 <20180323163453.96495-2-swboyd@chromium.org>
Message-ID: <20180326222511.hc6tzwb7n3svum2a@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2018 at 09:34:49AM -0700, Stephen Boyd wrote:
> From: Stephen Boyd <sboyd@codeaurora.org>
> 
> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues.
> Introduce a DT property to describe the set of GPIOs that are
> available for use so that higher level OSes are able to know what
> pins to avoid reading/writing.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/gpio/gpio.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
