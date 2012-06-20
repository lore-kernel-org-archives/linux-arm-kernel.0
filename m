From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 20 Jun 2012 15:27:33 +0100
Subject: [RFC] Support for 'Coda' video codec IP.
In-Reply-To: <20120620135633.GA2513@S2101-09.ap.freescale.net>
References: <1340115094-859-1-git-send-email-javier.martin@vista-silicon.com>
 <20120619181717.GE28394@pengutronix.de>
 <CACKLOr1zCp2NfLjBrHjtXpmsFMHqhoHFPpghN=Tyf3YAcyRrYg@mail.gmail.com>
 <20120620090126.GO28394@pengutronix.de>
 <20120620100015.GA30243@sirena.org.uk>
 <20120620130941.GB2253@S2101-09.ap.freescale.net>
 <20120620133148.GP3978@opensource.wolfsonmicro.com>
 <20120620135633.GA2513@S2101-09.ap.freescale.net>
Message-ID: <20120620142733.GQ3978@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 09:56:37PM +0800, Shawn Guo wrote:
> On Wed, Jun 20, 2012 at 02:31:48PM +0100, Mark Brown wrote:

> > Moving to irqdomain without DT is really very easy, you just need to
> > select a legacy mapping if a base is provided and otherwise all the code
> > is identical - it just comes down to a field in platform data and an if
> > statement.

> Yeah, but I guess what I'm saying is *linear* irqdomain.

Sure, but like I say the only code change required for keeping platform
data working is the three lines or so required to change to a legacy
mapping if you've got an irq_base.  All my development systems currently
use linear domains for several of the IRQ domains on a totally non-DT
system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120620/8d4f57e9/attachment.sig>
