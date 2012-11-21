From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Nov 2012 15:59:03 +0100
Subject: [PATCH 0/4] Dove pinctrl fixes and DT enabling
In-Reply-To: <CACRpkdYzQuv8sPk57CvqiwMmV0z007cGqVkGOENmr_aYAN14=Q@mail.gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkdYAnNCFDCjA67r0h_CSHMifb1Z83YJfYGQV3abPB8uQZg@mail.gmail.com>
 <50ACAAF5.2030002@gmail.com>
 <CACRpkdYzQuv8sPk57CvqiwMmV0z007cGqVkGOENmr_aYAN14=Q@mail.gmail.com>
Message-ID: <20121121155903.17f3e9cf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Wed, 21 Nov 2012 15:45:42 +0100, Linus Walleij wrote:

> > I am referring to patches for a pinctrl/mvebu subfolder. IIRC Thomas
> > posted that patch a while ago. Jason is currently sorting things out
> > for mvebu pull requests. I guess both can comment on your question,
> > as I don't fully understand it.
> 
> So what I mean is that the patches creating pinctrl/mvebu is in the
> pinctrl tree, so if patches in the MVEBU tree depend on these,
> then it must have pulled in a branch from pinctrl or applied the
> same patches in that tree too (which is OK *sometimes*).

I know there has been some discussion between Arnd and Jason Cooper
(who handles the pull requests for the overall mvebu effort) about this
specific topic. I think the outcome of the discussion was that Jason
would have to see how much the rest of the mvebu stuff depends on this
pinctrl/mvebu change and will see with Arnd how to proceed. But it's
certainly better if Jason gives you directly feedback about this.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
