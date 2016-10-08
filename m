From: Rob Herring <robh@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	linux-amlogic at lists.infradead.org,
	linux-arm-kernel at lists.infradead.org, devicetree at vger.kernel.org,
	linux-gpio at vger.kernel.org
Subject: Re: [RFC 05/10] dt-bindings: pinctrl: meson: update gpio dt-bindings
Message-ID: <20161008233300.GA22543@rob-hp-laptop>
References: <1475593708-10526-1-git-send-email-jbrunet@baylibre.com>
 <1475593708-10526-6-git-send-email-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475593708-10526-6-git-send-email-jbrunet@baylibre.com>
Date: Sat, 8 Oct 2016 18:33:03 -0500
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
