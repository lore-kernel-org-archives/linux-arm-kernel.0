From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 16:49:56 -0500
Subject: [PATCH v4 7/7] doc: bindings: act8945a-charger: Update properties
In-Reply-To: <1470636529-16387-8-git-send-email-wenyou.yang@atmel.com>
References: <1470636529-16387-1-git-send-email-wenyou.yang@atmel.com>
 <1470636529-16387-8-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160810214956.GA14844@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 02:08:49PM +0800, Wenyou Yang wrote:
> Due the driver improvements, update the properties,
>  - Remove "active-semi,check-battery-temperature" property.
>  - Add the properties, "active-semi,irq_gpio"
>    and "active-semi,lbo-gpios".
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v4:
>  - Update the doc/binding for using "interrupts" property.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../devicetree/bindings/power/act8945a-charger.txt       | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
