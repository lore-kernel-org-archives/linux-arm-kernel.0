From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Aug 2017 16:00:51 -0500
Subject: [PATCH v4 2/5] dt-bindings: add binding for Sitronix ST7586
 display panels
In-Reply-To: <1502127581-10517-3-git-send-email-david@lechnology.com>
References: <1502127581-10517-1-git-send-email-david@lechnology.com>
 <1502127581-10517-3-git-send-email-david@lechnology.com>
Message-ID: <20170810210051.5cqsaf65ymkzxksj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 12:39:38PM -0500, David Lechner wrote:
> This adds a new binding for Sitronix ST7586 display panels.
> 
> Using lego as the vendor prefix in the compatible string because the display
> panel I am working with is an integral part of the LEGO MINDSTORMS EV3.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v4 changes:
> * Dropped optional properties and only use pins actually used on LEGO EV3.
> * Rename dc to a0 since that is what is on the datasheet/LEGO schematic.
> 
> 
>  .../bindings/display/sitronix,st7586.txt           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7586.txt

Acked-by: Rob Herring <robh@kernel.org>
