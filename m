From: horms@verge.net.au (Simon Horman)
Date: Thu, 8 Jun 2017 15:47:41 +0200
Subject: [PATCH] ARM: shmobile: Update R-Car Gen3 ULCB board part numbers
In-Reply-To: <20170607221203.hgjp3izxpjuvxd7t@rob-hp-laptop>
References: <1496313269-27795-1-git-send-email-geert+renesas@glider.be>
 <20170607221203.hgjp3izxpjuvxd7t@rob-hp-laptop>
Message-ID: <20170608134741.GD19821@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 05:12:03PM -0500, Rob Herring wrote:
> On Thu, Jun 01, 2017 at 12:34:29PM +0200, Geert Uytterhoeven wrote:
> > The board part numbers for the R-Car H3 and M3 ULCB boards corresponded
> > to versions predating mass production.  Update them for mass production.
> > 
> > Note that the H3 ULCB board can be equipped with either revision ES1.1
> > or ES2.0 of the R-Car H3 SoC.  While these have different board part
> > numbers, no new compatible values are needed, as the revision can be
> > detected at runtime using the PRR register.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > See also http://elinux.org/index.php?title=R-Car/Boards/H3SK
> > 
> >  Documentation/devicetree/bindings/arm/shmobile.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, I have queued this up for v4.13.
