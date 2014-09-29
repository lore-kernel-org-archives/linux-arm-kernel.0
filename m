From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Sep 2014 11:52:27 +0200
Subject: [PATCH v2 6/7] devicetree: bindings: Document supported
 Allwinner sunxi SoCs
In-Reply-To: <CAGb2v65pKo=6BC-HaMsEMq-bcQcoHZNc9GiX+kfTBgP1PE5wMg@mail.gmail.com>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
 <1411570141-29960-7-git-send-email-wens@csie.org>
 <20140925133609.GK15315@lukather>
 <CAGb2v65pKo=6BC-HaMsEMq-bcQcoHZNc9GiX+kfTBgP1PE5wMg@mail.gmail.com>
Message-ID: <20140929095227.GD4388@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 27, 2014 at 09:08:46PM +0800, Chen-Yu Tsai wrote:
> On Thu, Sep 25, 2014 at 9:36 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Wed, Sep 24, 2014 at 10:49:00PM +0800, Chen-Yu Tsai wrote:
> >> This adds a list of supported Allwinner SoC bindings.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >>  Documentation/devicetree/bindings/arm/sunxi.txt | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/sunxi.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
> >> new file mode 100644
> >> index 0000000..d7d1039
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/sunxi.txt
> >> @@ -0,0 +1,12 @@
> >> +Allwinner sunXi Platforms Device Tree Bindings
> >> +
> >> +Each device tree must specify which Allwinner SoC it uses,
> >> +using one of the following compatible stirngs:
> >                                          ^ strings
> 
> Will fix.
> 
> >> +
> >> +  allwinner,sun4i-a10
> >> +  allwinner,sun5i-a10s
> >> +  allwinner,sun5i-a13
> >> +  allwinner,sun6i-a31
> >> +  allwinner,sun7i-a20
> >> +  allwinner,sun8i-a23
> >> +  allwinner,sun9i-a80
> >
> > Maybe you can just add this info to the already existing README?
> 
> AFAIK the bindings are where they're supposed to be.
> 
> Putting the bindings outside of devicetree/bindings is unexpected
> and confusing.

Ah, yes...

Sorry about the noise, I was somehow convinced our README were under
that directory, but you're obviously right :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/342ee36f/attachment.sig>
