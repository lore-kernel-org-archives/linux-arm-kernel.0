From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 16:49:04 -0500
Subject: [PATCH 1/3] ARM: shmobile: Document Renesas M3-W-based
 Salvator-XS board DT bindings
In-Reply-To: <1509384599-28953-2-git-send-email-geert+renesas@glider.be>
References: <1509384599-28953-1-git-send-email-geert+renesas@glider.be>
 <1509384599-28953-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20171101214904.b5adavvirlmphnqn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 06:29:57PM +0100, Geert Uytterhoeven wrote:
> The Renesas Salvator-XS (Salvator-X 2nd version) development board can
> be equipped with either an R-Car H3 ES2.0 or M3-W ES1.x SiP, which are
> pin-compatible.
> 
> Document board part number and compatible values for the version with
> R-Car M3-W.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
