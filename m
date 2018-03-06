From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Mar 2018 14:05:51 +0100
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <20180306125416.GD26143@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd> <20180306125416.GD26143@lunn.ch>
Message-ID: <20180306130551.GA16061@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-03-06 13:54:16, Andrew Lunn wrote:
> On Tue, Mar 06, 2018 at 01:40:02PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > > ---
> > >  .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
> > >  1 file changed, 73 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > > new file mode 100644
> > > index 000000000000..8a86f346d550
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > > @@ -0,0 +1,73 @@
> > > +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> > 
> > Are these SoCs x86-based?
> 
> ARM, as far as i can tell. If i get the architecture correct, these
> are BMC, Board Management Controllers, looking after the main x86 CPU,
> stopping it overheating, controlling the power supplies, remote
> management, etc.

Ok, so with x86 machine, I get arm-based one for free. I get it. Is
user able to run his own kernel on the arm system, or is it locked
down, TiVo style?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180306/e5be042a/attachment.sig>
