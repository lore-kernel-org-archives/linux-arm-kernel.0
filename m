From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 25 Jun 2012 09:46:56 +0100
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <27366523.LjLfRK1TqH@ax5200p>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <4127323.noaajNecru@ax5200p>
 <20120624123151.GZ4037@opensource.wolfsonmicro.com>
 <27366523.LjLfRK1TqH@ax5200p>
Message-ID: <20120625084656.GA4037@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 24, 2012 at 03:27:42PM +0200, Marc Dietrich wrote:
> On Sunday 24 June 2012 13:31:51 Mark Brown wrote:

> > > there should be some initial value, e.g. regulator-default-microvolt, as
> > > the original driver (from 2.6.32 ages) did. This way the maximum value
> > > can be set

> > That's *never* been in mainline, and nobody even bothered trying to
> > submit it.

> which was the best thing to do ;-)

Well, no - had there been some attempt to submit it it might've helped
stop people writing constaints like this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/8a8ff01d/attachment-0001.sig>
