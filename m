From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Jul 2017 21:32:54 +0200
Subject: [PATCH] dt-bindings: amlogic: add unstable statement
In-Reply-To: <20170705142015.tmlmes5lobadndsy@rob-hp-laptop>
References: <20170628145343.25443-1-khilman@baylibre.com>
 <20170705142015.tmlmes5lobadndsy@rob-hp-laptop>
Message-ID: <20170705193254.ulpoduoqlqf4ttkj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 05, 2017 at 09:20:15AM -0500, Rob Herring wrote:
> On Wed, Jun 28, 2017 at 07:53:43AM -0700, Kevin Hilman wrote:
> > Due to the lack of documentation on this SoC family, discovery of new
> > features, and correcting of previous misunderstandings is expected, so
> > it's unrealistic to expect any form of stable bindings for this SoC
> > family.  Make that clear inthe binding documentation.
> 
> s/inthe/in the/
> 
> > 
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/arm/amlogic.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> I've yet to see anyone remove an unstable tag and I'd rather see these 
> for individual bindings than for the platform as a whole. In the end, 
> it's a platform maintainers decision whether to accept compatibility 
> breakage regardless of some text that probably no one reads.

So what is the policy exactly to decide whether this statement can be
merged or not?

We have all the issues mentionned above, no backing from the vendor,
and yet, we were forced last year to bow down to one single "user"
without a clear usage into supporting a stable ABI that we never
really anticipated. How does that work exactly?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170705/3a5d9b5e/attachment.sig>
