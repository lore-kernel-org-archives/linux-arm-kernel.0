From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Jun 2012 21:13:44 +0800
Subject: [PATCH v2 3/3] ARM: mxs_defconfig: Let AUART driver be built by
 default
In-Reply-To: <201206151453.11469.marex@denx.de>
References: <1339759950-5507-1-git-send-email-festevam@gmail.com>
 <20120615123342.GJ31565@S2101-09.ap.freescale.net>
 <4FDB2F82.804@grid-net.com> <201206151453.11469.marex@denx.de>
Message-ID: <20120615131342.GL31565@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 02:53:11PM +0200, Marek Vasut wrote:
> Dear Subodh Nijsure,
> 
> > On 06/15/2012 05:33 AM, Shawn Guo wrote:
> > > On Fri, Jun 15, 2012 at 08:32:30AM -0300, Fabio Estevam wrote:
> > >> From: Fabio Estevam<fabio.estevam@freescale.com>
> > >> 
> > >> Let AUART driver be built by default.
> > >> 
> > >> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
> > > 
> > > Applied, thanks.
> > 
> > Applied to what? arm-soc/for-next ?
> 
> git://git.linaro.org/people/shawnguo/linux-2.6.git
> 
Yes, I collect patches there, and will send them to arm-soc at some
point.

> OR (probably later)
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
I do not have my branch included into linux-next and rely on
arm-soc/for-next to have the patches exposed on linux-next.

-- 
Regards,
Shawn
