From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Mar 2012 16:34:29 +0100
Subject: [PATCH v1] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD16@MEP-EXCH.meprolight.com>
References: <1332772593-13313-1-git-send-email-alexg@meprolight.com>
 <20120326144712.GA8579@sirena.org.uk>
 <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD16@MEP-EXCH.meprolight.com>
Message-ID: <20120326153429.GX3098@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 05:28:55PM +0200, Alex Gershgorin wrote:
> On Mon, Mar 26, 2012 at 04:36:33PM +0200, Alex Gershgorin wrote:

Fix your mailer to word wrap within paragraphs, I reflowed your text to
be legible.

> > >...and in many cases the supply names don't look like things I'd expect
> > >to be varying too much at runtime.  It looks like you just typed the
> > >maximum datasheet ranges in, not things that make sense for the board.

> It's not quite true, I was based on the Freescale BSP and I assume,
> that this is checked.  I also tested it on v3.3

Uh, presence in a vendor BSP isn't a guarantee of sanity...  Since you
didn't specify any consumers the regulator API obviously won't do
anything with the voltage range provided but to repeat it's really not
at all obvious that anything sane ever would.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120326/c9de4116/attachment.sig>
