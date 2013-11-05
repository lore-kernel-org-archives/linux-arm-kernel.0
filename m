From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Nov 2013 11:13:27 +0800
Subject: [PATCHv3] ARM: imx: add support code for IMX50 based machines
In-Reply-To: <52785FAE.7040904@uclinux.org>
References: <1383524020-1518-1-git-send-email-gerg@uclinux.org>
 <20131104145151.GD3060@titan.lakedaemon.net>
 <20131104145739.GE3060@titan.lakedaemon.net>
 <52785FAE.7040904@uclinux.org>
Message-ID: <20131105031325.GJ19770@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 01:02:06PM +1000, Greg Ungerer wrote:
> Hi Jason,
> 
> On 05/11/13 00:57, Jason Cooper wrote:
> > On Mon, Nov 04, 2013 at 09:51:51AM -0500, Jason Cooper wrote:
> >> What happened to the rest of the series?
> > 
> > Crap.  Nevermind.  I just saw that Shawn had already taken the other
> > patches into his tree.  And here I thought I was caught up on
> > everything...
> 
> :-)
> 
> Are you going to try and test out the imx50 support from Shawn's branch?

My for-next branch below should have all the bits except imx50 pinctrl
driver.

  git://git.linaro.org/people/shawnguo/linux-2.6.git for-next

Shawn
