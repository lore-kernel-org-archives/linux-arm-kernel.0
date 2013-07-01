From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 1 Jul 2013 22:17:12 +0800
Subject: [PATCH] ARM: dts: i.MX27: Add Secondary AHB Port definitions
In-Reply-To: <1372687690.31793480@f308.mail.ru>
References: <1372487325-14405-1-git-send-email-shc_work@mail.ru>
 <20130701125819.GJ13206@S2101-09.ap.freescale.net>
 <1372687690.31793480@f308.mail.ru>
Message-ID: <20130701141710.GQ13206@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 06:08:10PM +0400, Alexander Shiyan wrote:
> Introducing primary bus will produce a completely different i.MX27 DTS,
> since it contain AIPI1,2 and iram.

That's one reason I would stay away from the change, because if the
addition of Secondary AHB is accepted, it will be a little more
difficult for us to say NO to people who love to have Primary AHB added.

> Introduction of buses has no effect, other than the possibility of using labels
> and minimal validation of nodes to the correct address.

Only if there is no code in the kernel searching a node via node path.

> In this case, I define the bus here for the subsequent addition of WEIM,
> for a better understanding of what and where is.
> Of course we can do without it. Think is it unnecessary?

Great, please do without it then, thanks.

Shawn
