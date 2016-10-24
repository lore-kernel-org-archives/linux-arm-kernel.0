From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Oct 2016 21:49:17 +0200
Subject: [PATCH v3 3/6] dt-bindings: pinctrl: Deprecate sunxi pinctrl
 bindings
In-Reply-To: <CACRpkdb7zs7Nhs3i1o=WUt787vJCuePre3Tj3wLu++qwpO0atQ@mail.gmail.com>
References: <cover.f893b02a9f816dad8fad3986672b05c4b211e2b1.1476971126.git-series.maxime.ripard@free-electrons.com>
 <6aec73cd3b9d3dbf1085d042ec6c23f385a300de.1476971126.git-series.maxime.ripard@free-electrons.com>
 <CACRpkdb7zs7Nhs3i1o=WUt787vJCuePre3Tj3wLu++qwpO0atQ@mail.gmail.com>
Message-ID: <20161024194917.g5oezqc4uacsyt24@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Oct 24, 2016 at 02:03:59AM +0200, Linus Walleij wrote:
> On Thu, Oct 20, 2016 at 3:49 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > The generic pin configuration and multiplexing should be preferred now,
> > even though we still support the old one.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Patch applied.

Thanks a lot.

However, it looks like the first patch from this serie is missing from
your tree, is there a reason for that?

Also, in order to preserve bisectability, could you create an
immutable branch for those sunxi patches so that I can merge the DT
bits?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/b378beb9/attachment.sig>
