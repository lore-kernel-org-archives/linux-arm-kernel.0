From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 09:46:29 +0100
Subject: [PATCH 10/11] arm64: dts: allwinner: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <CAGb2v66cQoPQzd6W1D8bZ5hSURfGP3icJjeoo1mNk2ccG9B2vw@mail.gmail.com>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-11-wens@csie.org>
 <20170126101529.j3fuku4hyy3pbge3@lukather>
 <CAGb2v66cQoPQzd6W1D8bZ5hSURfGP3icJjeoo1mNk2ccG9B2vw@mail.gmail.com>
Message-ID: <20170127084629.hborqgkmm4exo7z7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 07:23:25PM +0800, Chen-Yu Tsai wrote:
> On Thu, Jan 26, 2017 at 6:15 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Jan 24, 2017 at 10:32:29AM +0800, Chen-Yu Tsai wrote:
> >> All dts files for the sunxi platform have been switched to the generic
> >> pinconf bindings. As a result, the sunxi specific pinctrl macros are
> >> no longer used.
> >>
> >> Remove the #include entry with the following command:
> >>
> >>     sed -i -e '/pinctrl\/sun4i-a10.h/D' \
> >>       arch/arm64/boot/dts/allwinner/*.dts?
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Applied, thanks!
> >
> > Maybe we should also remove the header entirely?
> 
> I don't know. What do we do about deprecated bindings?

Well, we have to support the old device trees, but I don't think to be
expected to still compile them from the source

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/0488d77b/attachment.sig>
