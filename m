From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 Nov 2017 08:58:25 +0100
Subject: [PATCH 1/3] ARM: shmobile: Document Renesas M3-W-based
 Salvator-XS board DT bindings
In-Reply-To: <20171101214904.b5adavvirlmphnqn@rob-hp-laptop>
References: <1509384599-28953-1-git-send-email-geert+renesas@glider.be>
 <1509384599-28953-2-git-send-email-geert+renesas@glider.be>
 <20171101214904.b5adavvirlmphnqn@rob-hp-laptop>
Message-ID: <20171102075825.3hiqwfbxjpqmeayp@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 04:49:04PM -0500, Rob Herring wrote:
> On Mon, Oct 30, 2017 at 06:29:57PM +0100, Geert Uytterhoeven wrote:
> > The Renesas Salvator-XS (Salvator-X 2nd version) development board can
> > be equipped with either an R-Car H3 ES2.0 or M3-W ES1.x SiP, which are
> > pin-compatible.
> > 
> > Document board part number and compatible values for the version with
> > R-Car M3-W.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, applied.
