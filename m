From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Dec 2013 11:37:05 +0000
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <20131217021610.GA7172@S2101-09.ap.freescale.net>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131216112910.GB30671@S2101-09.ap.freescale.net>
 <20131217015939.GM3185@sirena.org.uk>
 <20131217021610.GA7172@S2101-09.ap.freescale.net>
Message-ID: <20131217113705.GP3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 10:16:13AM +0800, Shawn Guo wrote:
> On Tue, Dec 17, 2013 at 01:59:39AM +0000, Mark Brown wrote:

> > It's something that the platform needs to address - the core has no way
> > of figuring out what devices might register in future if the platform
> > doesn't tell them.

> Okay.  But is there an established means for platform to tell that?

That's what has_full_constraints() is for.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131217/e80a3af6/attachment-0001.sig>
