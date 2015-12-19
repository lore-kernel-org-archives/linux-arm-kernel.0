From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Dec 2015 22:19:35 -0600
Subject: [PATCH v2 1/3] clk: bcm2835: Add bindings for the auxiliary
 peripheral clock gates.
In-Reply-To: <1450222559-22461-1-git-send-email-eric@anholt.net>
References: <1450222559-22461-1-git-send-email-eric@anholt.net>
Message-ID: <20151219041935.GS14936@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 03:35:57PM -0800, Eric Anholt wrote:
> These will be used for enabling UART1, SPI1, and SPI2.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: Make the binding cover both the IRQ and clock enable registers.
> 
>  .../bindings/clock/brcm,bcm2835-aux-clock.txt      | 31 ++++++++++++++++++++++
>  include/dt-bindings/clock/bcm2835-aux.h            | 17 ++++++++++++
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-aux-clock.txt
>  create mode 100644 include/dt-bindings/clock/bcm2835-aux.h

Acked-by: Rob Herring <robh@kernel.org>
