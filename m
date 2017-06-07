From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 17:42:57 -0500
Subject: [PATCH v3 5/6] dt-bindings: display: amlogic: DT fix
 s/resets-names/reset-names/
In-Reply-To: <1496407129-13527-6-git-send-email-geert+renesas@glider.be>
References: <1496407129-13527-1-git-send-email-geert+renesas@glider.be>
 <1496407129-13527-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20170607224257.aqwrv7ryxrtr7yva@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 02, 2017 at 02:38:48PM +0200, Geert Uytterhoeven wrote:
> Fixes: 8cceda5349377e30 ("dt-bindings: Add bindings for the Amlogic Meson dw-hdmi extension")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - New.
> ---
>  Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
