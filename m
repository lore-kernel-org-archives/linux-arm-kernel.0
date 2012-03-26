From: alexg@meprolight.com (Alex Gershgorin)
Date: Mon, 26 Mar 2012 20:56:35 +0200
Subject: [PATCH v1] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <20120326153429.GX3098@opensource.wolfsonmicro.com>
References: <1332772593-13313-1-git-send-email-alexg@meprolight.com>
 <20120326144712.GA8579@sirena.org.uk>
 <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD16@MEP-EXCH.meprolight.com>,
 <20120326153429.GX3098@opensource.wolfsonmicro.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CC34CAD1F@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, Mar 26, 2012 at 05:28:55PM +0200, Alex Gershgorin wrote:
> On Mon, Mar 26, 2012 at 04:36:33PM +0200, Alex Gershgorin wrote:

> It's not quite true, I was based on the Freescale BSP and I assume,
> that this is checked.  I also tested it on v3.3

> > Uh, presence in a vendor BSP isn't a guarantee of sanity...  Since you
> > didn't specify any consumers the regulator API obviously won't do
> > anything with the voltage range provided but to repeat it's really not
> > at all obvious that anything sane ever would.

Thanks Mark I think that understand you,
if not have consumers do not set ranges.
I will correct it

Thanks 
Alex Gershgorin
