From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 17:43:18 -0500
Subject: [PATCH v3 6/6] dt-bindings: net: btusb: DT fix
 s/interrupt-name/interrupt-names/
In-Reply-To: <1496407129-13527-7-git-send-email-geert+renesas@glider.be>
References: <1496407129-13527-1-git-send-email-geert+renesas@glider.be>
 <1496407129-13527-7-git-send-email-geert+renesas@glider.be>
Message-ID: <20170607224318.wswmmhdwmqtvvqob@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 02:38:49PM +0200, Geert Uytterhoeven wrote:
> Fixes: fd913ef7ce619467 ("Bluetooth: btusb: Add out-of-band wakeup support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  Documentation/devicetree/bindings/net/btusb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
