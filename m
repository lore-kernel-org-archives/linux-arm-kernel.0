From: cjb@laptop.org (Chris Ball)
Date: Fri, 22 Oct 2010 01:27:38 +0100
Subject: [PATCH V3 1/1]MMC: add support of sdhci-pxa driver
In-Reply-To: <201010220220.10398.marek.vasut@gmail.com>
References: <AANLkTikivxhU6Lzxe0Xn9r9hOSPLwuySRkTdGif4F_xo@mail.gmail.com>
	<20101021141302.GA11912@void.printf.net>
	<20101021145249.GA13095@void.printf.net>
	<201010220220.10398.marek.vasut@gmail.com>
Message-ID: <20101022002738.GA688@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Oct 22, 2010 at 02:20:10AM +0200, Marek Vasut wrote:
> > > I'll take the drivers/mmc/ hunks, but you should send the plat-pxa/
> > > patch through the ARM tree.
> > 
> > Oh.  If we do that then the driver won't compile until everything's
> > together, because it #includes <plat/sdhci.h>.  Haojian/Eric, what do
> > you prefer here?  Should I take the arch/arm/ hunk via the MMC tree?
> > (If so, please provide ACKs.)
> 
> Hi, where can I find the whole driver so I can take a look? It didn't 
> crash into linux-arm-kernel for some reason.

Here it is:

http://thread.gmane.org/gmane.linux.kernel.mmc/4190

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
