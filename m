From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 May 2015 17:15:30 +0200
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Replace USB_RCAR_GEN2_PHY by
 PHY_RCAR_GEN2
In-Reply-To: <20150509021403.GA18443@verge.net.au>
References: <1430222884-2095-1-git-send-email-geert+renesas@glider.be>
 <20150430001743.GF17758@verge.net.au> <20150509021403.GA18443@verge.net.au>
Message-ID: <3385193.PYJYK5jiMy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 May 2015 11:14:03 Simon Horman wrote:
> On Thu, Apr 30, 2015 at 09:17:44AM +0900, Simon Horman wrote:
> > On Tue, Apr 28, 2015 at 02:08:04PM +0200, Geert Uytterhoeven wrote:
> > > The legacy-only USB_RCAR_GEN2_PHY driver was replaced by the DT-only
> > > PHY_RCAR_GEN2 driver.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > Oops, CONFIG_USB_RCAR_GEN2_PHY shouldn't have been in a multiplatform
> > > defconfig, as it supports legacy platform data only.
> > 
> > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Olof, Arnd, Kevin,
> > 
> > I'm assuming that you want to take this directly (or not!).
> > However, if you would like me to queue up these kind of changes
> > in my defconfig branch please just let me know.
> 
> Hi,
> 
> I'm wondering if you could take a moment to either review this patch
> or indicate that you would like me to queue up changes like this.

The patch looks ok to me, and I've queued it up in the next/defconfig
branch for 4.2 now.

In general, I think it's easier if you take all patches at first and
then forward them to us, that way we can rely on you to have an
overview of what is missing.

If you only have one patch for a particular branch, sending a patch
(instead of a pull request) to arm at kernel.org works as well, but it's
less ambiguous if you relay that patch with your signed-off-by line
added than to have us figure out whether you want the patch to be
applied directly or not.

	Arnd
