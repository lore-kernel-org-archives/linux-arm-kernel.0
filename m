From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Mar 2016 16:29:03 -0500
Subject: [PATCH v5 1/2] ARM: dts: at91: shdwc binding: add new shutdown
 controller documentation
In-Reply-To: <1458134390-23847-2-git-send-email-nicolas.ferre@atmel.com>
References: <1458134390-23847-1-git-send-email-nicolas.ferre@atmel.com>
 <1458134390-23847-2-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20160318212903.GA9179@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 02:19:49PM +0100, Nicolas Ferre wrote:
> The new shutdown controller compatible with sama5d2 has a new binding
> documentation and properties.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> 
> doc
> 
> ---
> 
> Changes in v5:
> - change naming for this driver: instead of the "alternate shdwc" we choose a
>   more specific "sama5d2-compatible shdwc" wording.
> 
> Changes in v4:
> - change property to debounce-delay-us so that we can use a generic property
>   and we can have the unit explicitly included it the name according to
>   Documentation/devicetree/bindings/property-units.txt.
> - move to atmel,wakeup-active-high boolean property instead of a "high", "low"
>   string comparison.
> 
> Changes in v3:
> - get and use slow clock and specify its handler in binding
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/arm/atmel-at91.txt         | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
