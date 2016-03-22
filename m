From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 Mar 2016 10:55:55 +0900
Subject: [PATCH 00/12] ARM, arm64: dts: use generic pinctrl properties
In-Reply-To: <CAMuHMdVpAg8ixL_x94qBS1tkKWjSXdYuvo4EcD7YVU1sZQ4E8w@mail.gmail.com>
References: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVpAg8ixL_x94qBS1tkKWjSXdYuvo4EcD7YVU1sZQ4E8w@mail.gmail.com>
Message-ID: <20160322015554.GD14367@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 11:59:25AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Mar 18, 2016 at 12:59 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
> > groups properties") renesas pfc drivers accept generic "function", "pins"
> > and "groups" properties.
> >
> > This series updates the device trees for the boards of Renesas ARM based
> > SoCs to use the generic properties. The device tree for the lager board was
> > already updated in an earlier patch which is present in
> > renesas-devel-20160318-v4.5.
> >
> > Based on renesas-devel-20160318-v4.5
> 
> Thanks!
> 
> For the whole series:
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued these up.

> Doh, now I have to update all my DT overlays, as you cannot mix new-style
> and old-style properties ;-)

Sorry about that.
