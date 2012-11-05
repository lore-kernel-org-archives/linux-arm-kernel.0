From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Mon, 5 Nov 2012 18:00:53 +0100
Subject: [PATCH] lpc32xx: irq - Set the chain handlers after setting up
 the IRQ domain
In-Reply-To: <50938BFD.1000402@antcom.de>
References: <1351772626-12615-1-git-send-email-alban.bedel@avionic-design.de>
 <50938BFD.1000402@antcom.de>
Message-ID: <20121105180053.20090a3e@avionic-0020.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Nov 2012 10:01:49 +0100
Roland Stigge <stigge@antcom.de> wrote:

> Thanks for your patch!
> 
> I already posted basically the same change on 2012-10-28 already which
> is part of my patch set for LPC32xx to be merged into arm-soc.git (will
> do a pull request later). Fixing another irq bug in this platform/irq also.

I checked arm-soc.git, linux-next.git, linux-arm-kernel@ and
linux-kernel@, is there any other place I should check before
submitting LPC32xx patches?

> Please also note that panic() doesn't return, so I won't include the
> respective new return that you added.

OK

Alban
