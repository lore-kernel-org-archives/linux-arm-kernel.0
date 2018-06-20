From: robh@kernel.org (Rob Herring)
Date: Wed, 20 Jun 2018 09:40:09 -0600
Subject: [PATCH v4 15/19] dt-bindings: media: Document bindings for the
 Sunxi-Cedrus VPU driver
In-Reply-To: <20180618145843.14631-16-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-16-paul.kocialkowski@bootlin.com>
Message-ID: <20180620154009.GA26099@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 04:58:39PM +0200, Paul Kocialkowski wrote:
> This adds a device-tree binding document that specifies the properties
> used by the Sunxi-Cedurs VPU driver, as well as examples.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> 
>  create mode 100644 Documentation/devicetree/bindings/media/sunxi-cedrus.txt

You are missing a '---' line so this is going to end up in the commit 
msg.

Please add acked/reviewed bys when posting new versions.

Rob
