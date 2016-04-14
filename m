From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 12:21:09 -0500
Subject: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
In-Reply-To: <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20160414172109.GA15021@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 02:13:19PM +0200, Geert Uytterhoeven wrote:
> Document a set of generic properties for describing UARTs in a
> device tree:
>   1. The GPIO modem control properties are currently duplicated across
>      hardware-specific binding documentation,
>   2. The property for dedicated RTS/CTS hardware flow control lines is
>      already supported by several drivers, albeit with a vendor-specific
>      prefix, hence make it generic.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/serial/serial.txt          | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/serial.txt

Thanks for doing this.

Acked-by: Rob Herring <rob@kernel.org>
