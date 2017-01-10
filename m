From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 23:35:50 -0600
Subject: [PATCH RFC 3/4] dt-bindings: correct marvell orion MDIO binding
 document
In-Reply-To: <E1cPpAk-0005uJ-TM@rmk-PC.armlinux.org.uk>
References: <20170107112656.GL14217@n2100.armlinux.org.uk>
 <E1cPpAk-0005uJ-TM@rmk-PC.armlinux.org.uk>
Message-ID: <20170110053550.e4igrh5dxfgsbtqc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 07, 2017 at 11:28:30AM +0000, Russell King wrote:
> Correct the Marvell Orion MDIO binding document to properly reflect the
> cases where an interrupt is present.  Augment the examples to show this.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  .../devicetree/bindings/net/marvell-orion-mdio.txt      | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
