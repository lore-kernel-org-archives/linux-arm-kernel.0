From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 15:38:26 -0600
Subject: [PATCH 10/12] dt-bindings: rng: Incorporate brcm,bcm6368.txt
 binding
In-Reply-To: <20171102010408.27736-11-f.fainelli@gmail.com>
References: <20171102010408.27736-1-f.fainelli@gmail.com>
 <20171102010408.27736-11-f.fainelli@gmail.com>
Message-ID: <20171106213826.vetpedvdiwwmo4hs@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 06:04:06PM -0700, Florian Fainelli wrote:
> Since the same block is used on BCM2835 and BCM6368, merge the bindings
> and remove the brcm,bcm6368.txt binding document.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/rng/brcm,bcm2835.txt       | 22 +++++++++++++++++++---
>  .../devicetree/bindings/rng/brcm,bcm6368.txt       | 17 -----------------
>  2 files changed, 19 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm6368.txt

Acked-by: Rob Herring <robh@kernel.org>
