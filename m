From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Nov 2018 11:40:43 +0100
Subject: [PATCH 02/77] ARM: dts: sun4i: Fix HDMI output DTC warning
In-Reply-To: <CAGb2v659iC4jTAm7J4+p5vWSSUT5ndjAR69OvKNd+QcPoC1ZmA@mail.gmail.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <f94e560d48baed0c5d9932eec1102c1fe76ff29d.1543321707.git-series.maxime.ripard@bootlin.com>
 <CAGb2v659iC4jTAm7J4+p5vWSSUT5ndjAR69OvKNd+QcPoC1ZmA@mail.gmail.com>
Message-ID: <20181128104043.f4kj34dhlj3fy5u7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 10:53:22AM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Our HDMI output endpoint on the A10 DTSI has a warning under DTC: "graph
> > node has single child node 'endpoint', #address-cells/#size-cells are not
> > necessary". Fix this by removing those properties.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/494e176f/attachment.sig>
