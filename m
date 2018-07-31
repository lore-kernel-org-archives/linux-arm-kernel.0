From: robh@kernel.org (Rob Herring)
Date: Tue, 31 Jul 2018 13:18:20 -0600
Subject: [PATCH v6 1/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix
 documentation of 'reg'
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
References: <20180731185917.176074-1-mka@chromium.org>
Message-ID: <20180731191820.GA1723@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 11:59:13AM -0700, Matthias Kaehlcke wrote:
> The documentation claims that the 'reg' property consists of two values,
> the SPMI address and the length of the controller's registers. However
> the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
> the controller register length from the documentation of the field and the
> example.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
