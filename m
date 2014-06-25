From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 25 Jun 2014 10:29:41 +0800
Subject: [PATCH v14 05/10] ARM: dts: imx5*, imx6*: correct
 display-timings nodes.
In-Reply-To: <20140624150158.GS32514@n2100.arm.linux.org.uk>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-5-git-send-email-denis@eukrea.com>
 <20140624150158.GS32514@n2100.arm.linux.org.uk>
Message-ID: <20140625022939.GA5732@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 04:01:58PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 16, 2014 at 12:11:19PM +0200, Denis Carikli wrote:
> > The imx-drm driver can't use the de-active and
> > pixelclk-active display-timings properties yet.
> > 
> > Instead the data-enable and the pixel data clock
> > polarity are hardcoded in the imx-drm driver.
> > 
> > So theses properties are now set to keep
> > the same behaviour when imx-drm will start
> > using them.
> > 
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> 
> This patch needs either an ack from the arm-soc/iMX maintainers, or
> they need to merge it.  As there's little positive agreement on the
> series, I can understand why there's reluctance to merge it.
> 
> So, can we start having some acks from people please, or at least
> commitments to merge this patch when the others are deemed to be
> acceptable.  If not, can we have explanations why this should not
> be merged.

I will be happy to merge dts change through IMX tree once the
binding/diver part gets accepted/applied.

Shawn
