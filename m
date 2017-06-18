From: robh@kernel.org (Rob Herring)
Date: Sun, 18 Jun 2017 09:04:33 -0500
Subject: [PATCH 1/4] ARM: shmobile: Document Renesas H3-based Salvator-XS
 board DT bindings
In-Reply-To: <1497008629-3974-2-git-send-email-geert+renesas@glider.be>
References: <1497008629-3974-1-git-send-email-geert+renesas@glider.be>
 <1497008629-3974-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20170618140433.xeqzggrrtcy2muoa@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 01:43:46PM +0200, Geert Uytterhoeven wrote:
> The Renesas Salvator-XS (Salvator-X 2nd version) development board can
> be equipped with either an R-Car H3 ES2.0 or M3-W ES1.x SiP, which are
> pin-compatible.
> 
> Document board part number and compatible values for the version with
> R-Car H3.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
