From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Mar 2017 20:57:55 -0500
Subject: [PATCH v8 2/3] dt-bindings: input: touchscreen: Add max11801-ts
 binding
In-Reply-To: <1490209518-20790-2-git-send-email-jagan@openedev.com>
References: <1490209518-20790-1-git-send-email-jagan@openedev.com>
 <1490209518-20790-2-git-send-email-jagan@openedev.com>
Message-ID: <20170329015755.zi77exu7tpne3g3n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 12:35:17AM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan@amarulasolutions.com>
> 
> Add missing documentation of max11801-ts dt-binding details.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v8:
> - Use IRQ_TYPE_EDGE_FALLING for interrupt trigger type. 
> Changes for v7:
> - add vendor prefix as maxim
> Changes for v6:
> - Replace the lable and name of the node
>    ts: max11801 => max11801: touchscreen at 48
> Changes for v5:
> - Newly added patch
> 
>  .../bindings/input/touchscreen/max11801-ts.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt

Acked-by: Rob Herring <robh@kernel.org>
