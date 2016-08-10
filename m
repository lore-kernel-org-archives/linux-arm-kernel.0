From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 16:40:54 -0500
Subject: [PATCH 2/3] dt-bindings: clock: reset: Add GXBB AO Clock and
 Reset Bindings
In-Reply-To: <1470734008-18849-3-git-send-email-narmstrong@baylibre.com>
References: <1470734008-18849-1-git-send-email-narmstrong@baylibre.com>
 <1470734008-18849-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <20160810214054.GA14766@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 11:13:27AM +0200, Neil Armstrong wrote:
> Add documentations and dt-bindings headers for the AO clock and reset
> controller.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/clock/amlogic,gxbb-aoclkc.txt         | 45 +++++++++++++++
>  include/dt-bindings/clock/gxbb-aoclkc.h            | 66 ++++++++++++++++++++++
>  include/dt-bindings/reset/gxbb-aoclkc.h            | 66 ++++++++++++++++++++++
>  3 files changed, 177 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
>  create mode 100644 include/dt-bindings/clock/gxbb-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/gxbb-aoclkc.h

Acked-by: Rob Herring <robh@kernel.org>
