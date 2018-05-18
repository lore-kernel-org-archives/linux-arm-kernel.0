From: robh@kernel.org (Rob Herring)
Date: Fri, 18 May 2018 09:24:18 -0500
Subject: [PATCH v10 24/27] dt-bindings: timer: new bindings for TI
 DaVinci timer
In-Reply-To: <20180509172606.29387-25-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
 <20180509172606.29387-25-david@lechnology.com>
Message-ID: <20180518142418.GA2298@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 12:26:03PM -0500, David Lechner wrote:
> This adds new device tree bindings for the timer IP block of TI
> DaVinci-like SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v10 changes:
> - changed compatible to "ti,da830-timer"
> - added interrupts and interrupt-names properties
> - fixed grammatical error
> 
> v9 changes:
> - new patch in v9
> 
> 
>  .../bindings/timer/ti,davinci-timer.txt       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ti,davinci-timer.txt

Reviewed-by: Rob Herring <robh@kernel.org>
