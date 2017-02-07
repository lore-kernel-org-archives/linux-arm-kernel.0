From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 7 Feb 2017 16:04:37 +0100
Subject: [PATCH 0/2] pinctrl: sunxi: Merge A31s pinctrl driver with A31
In-Reply-To: <CACRpkdZUOszrqbPq4Ak+pUeYQB2qBnSrE2qWMkoNzvw+E74maw@mail.gmail.com>
References: <20170201162547.24232-1-wens@csie.org>
 <20170202081332.okjxo4ogm2kp3abh@lukather>
 <CACRpkdZUOszrqbPq4Ak+pUeYQB2qBnSrE2qWMkoNzvw+E74maw@mail.gmail.com>
Message-ID: <20170207150437.ob77nbtanmsijoeh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Feb 06, 2017 at 11:07:33AM +0100, Linus Walleij wrote:
> On Thu, Feb 2, 2017 at 9:13 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Feb 02, 2017 at 12:25:45AM +0800, Chen-Yu Tsai wrote:
> >> Hi everyone,
> >>
> >> This series merges support for the A31s' pin controller into the A31
> >> driver, using the new sunxi variants support code. The A31s is a trimmed
> >> down version of the A31, with some hardware blocks removed, and some
> >> pin functions or pins removed. Thus it is easy to support the A31s
> >> using the A31 driver by marking the extra pins/functions as A31 only.
> >>
> >> Patch 1 does exactly this.
> >>
> >> Patch 2 removes the original A31s driver, which is now redundant.
> >>
> >> I opted not to rename sun6i-a31 to sun6i in various places.
> >
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Could you guys make a patch either adding these drivers as
> commonly maintained by you two in MAINTAINERS?
> 
> It is commonly maintained right?
> 
> Or if you prefer, just list the pinctrl dir under the Allwinner
> SoC support entry?

I'm not sure what you mean. We already have a wildcard matching sun*i
in our maintainer entry, so the pinctrl driver is definitely covered.

Or do you want us to add an explicit one?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/8144d9be/attachment.sig>
