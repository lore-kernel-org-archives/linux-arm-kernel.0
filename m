From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 Jan 2014 22:00:08 -0800
Subject: [GIT PULL] DaVinci GPIO updates for v3.14
In-Reply-To: <52CA5447.4060703@ti.com>
References: <52BB2C1E.5010300@ti.com>
 <52CA5447.4060703@ti.com>
Message-ID: <20140109060008.GA8285@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 12:29:19PM +0530, Sekhar Nori wrote:
> On Thursday 26 December 2013 12:33 AM, Sekhar Nori wrote:
> > Hi Arnd, Olof, Kevin,
> > 
> > Here are some DaVinci GPIO driver updates and the resulting platform 
> > code changes. All the patches have been acked by Linus. To handle
> > dependencies easily, we both agreed that it will be better I send the
> > driver updates via ARM-SoC. There is a new DT-binding which has been
> > acked by Rob H.
> > 
> > I have made the pull request over -rc4 instead of an older -rc because 
> > of this work depends on some fixes merged in that -rc (even for a 
> > successful build).
> 
> Can you please pull this?

Already done, seems that I missed emailing about it.

$ git branch --contains 6075a8b2b6c32ddcb99b85189ae41ab2903e560f
  davinci/gpio
  for-next
  next/drivers
  to-build


-Olof
