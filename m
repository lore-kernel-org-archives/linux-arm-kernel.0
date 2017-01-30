From: robh@kernel.org (Rob Herring)
Date: Mon, 30 Jan 2017 13:56:35 -0600
Subject: [PATCH v2 1/4] dt-bindings: clock: renesas: cpg-mssr: Document
 reset control support
In-Reply-To: <1485335703-27184-2-git-send-email-geert+renesas@glider.be>
References: <1485335703-27184-1-git-send-email-geert+renesas@glider.be>
 <1485335703-27184-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20170130195635.drveyzxfqrvj5fnh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:15:00AM +0100, Geert Uytterhoeven wrote:
> Document properties needed to use the Reset Control feature of the
> Renesas Clock Pulse Generator / Module Standby and Software Reset
> module.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Change oneline summary to refer to dt-bindings.
> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
