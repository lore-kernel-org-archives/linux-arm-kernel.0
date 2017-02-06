From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 6 Feb 2017 18:39:19 +0100
Subject: [PATCH 9/9] ARM: sun5i: gr8: Use common sun5i DTSI
In-Reply-To: <CAGb2v644NjJGEhQhvML2KOHBChpGMPzDAzdZS8xF2u0C83egag@mail.gmail.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <f9e1a964b48561cb52b68cad690d35ea793c95d0.1486320544.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v644NjJGEhQhvML2KOHBChpGMPzDAzdZS8xF2u0C83egag@mail.gmail.com>
Message-ID: <20170206173919.ier7fh7wztf7s2cg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 06, 2017 at 03:30:11PM +0800, Chen-Yu Tsai wrote:
> On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Most of the GR8 DTSI is duplicated with the common sun5i DTSI, and some of
> > the extra nodes defined there actually apply to all of the sun5i family.
> >
> > Move those into the common DTSI so that all SoCs can benefit from it, and
> > include the sun5i DTSI.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I think it's possible to move the display-engine node over as well?

I left it out for now, because if we follow our current rule, we will
have a different display engine for the A10s that has the HDMI
encoder.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170206/a8c9f0a2/attachment.sig>
