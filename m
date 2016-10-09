From: robh@kernel.org (Rob Herring)
Date: Sat, 8 Oct 2016 20:29:33 -0500
Subject: [RFC 05/10] dt-bindings: pinctrl: meson: update gpio dt-bindings
In-Reply-To: <1475593708-10526-6-git-send-email-jbrunet@baylibre.com>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
 <1475593708-10526-6-git-send-email-jbrunet@baylibre.com>
Message-ID: <20161009012933.GW18158@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 05:08:23PM +0200, Jerome Brunet wrote:
> Add description for the interrupt-parent property of the gpio sub-node
> If provided here, this property must be a phandle to an interrupt
> controller suitable for meson pinctrl, like the meson gpio interrupt
> controller.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
