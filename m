From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 17 Mar 2015 11:10:11 +0900
Subject: [PATCH v4 2/5] ARM: dts: Prepare exynos5410-odroidxu device tree
In-Reply-To: <CABxcv=kXkMkGkq=xjEBkfzdeFZ7XHDhneAxCgANoMDZ4u2Z4yw@mail.gmail.com>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-3-git-send-email-afaerber@suse.de>
 <CABxcv==cnFQ75qaykfkOcFo8FNqkzVswu8iYOB3riZJT9=4U_Q@mail.gmail.com>
 <5506B02D.3000400@suse.de>
 <CABxcv=kXkMkGkq=xjEBkfzdeFZ7XHDhneAxCgANoMDZ4u2Z4yw@mail.gmail.com>
Message-ID: <07a201d06057$800cd410$80267c30$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier Martinez Canillas wrote:
> 
> Hello Andreas,
> 
Hi,

> On Mon, Mar 16, 2015 at 11:27 AM, Andreas F?rber <afaerber@suse.de> wrote:
> > Am 16.03.2015 um 08:56 schrieb Javier Martinez Canillas:
> >>
> >> I think this should be defined in exynos5410.dtsi instead since is an
> >> IP block in the SoC and referenced in the .dts using a label to change
> >> the clock-frequency in the board.
> >
> > I hope you understood that this is a literal copy of smdk5410, so I'm
> > not going to make random changes here. If the Samsung guys want to make
> > this change for smdk5410, then fine, but otherwise - like for Snow and
> > Spring - I want to keep the diff -u low between the two.
> >
> 
> Yes I did understand that it was a copy but I thought it could be
> improved anyways. But I don't have a strong opinion either to block
> this series and always both DTS can be changed as a follow-up. So I'm
> ok with your decision to keeping the delta to the minimum for now.
> 
Yeah, everybody can update everything in mainline if it can be got review in
mailinglist. BTW asthe fin_pll can be different according to board condition
that's why it is defined in each boart DT file, it is mostly same on each
boards though...So I think keeping it would be more make sense.

Thanks,
Kukjin
