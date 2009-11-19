From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 19 Nov 2009 16:32:41 +0000
Subject: i.MX audio support
In-Reply-To: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20091119163241.GB31336@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 04:48:14PM +0100, Sascha Hauer wrote:

> There already is a driver for i.MX in the tree, this one is a nearly complete
> rewrite. I haven't touched the in Kernel driver with these patches. The in
> Kernel driver has several problems, it doesn't use ioremap, uses direct pointer
> derefs instead of proper access functions and the only board supported so far is
> itself not supported in mainline.

BTW, unless I notice anything particularly bad in there I'm inclined to
just merge all the arch/arm patches by themselves since obviously you're
the maintainer they'd normally go via - I'm assuming the other patches
depend on them?

Thanks a lot for doing this work - I've got some boards that I could
make a lot of use of if we had i.MX3x audio support in mainline!
