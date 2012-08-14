From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 19:56:53 -0400
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
Message-ID: <20120814235653.GA22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 09:06:16PM +0100, Ownerx35 wrote:
> I have created a patch and have tested it myself that create a board
> setup file for the Iomega StoreCenter IX2-200, create a dts file and
> insert the appropriate lines into the common.h, makefile,
> makefile.boot, kconfig and board-ft files.

Awesome!

> But am unsure how to properly submit it should i just post it here? or
> is there a specific place i should post?

Take a look at /path/to/linux_src/Documentation/SubmittingPatches .

If you prefer working with git, the two commands I use are format-patch
and then send-email.

Assuming the board is ARM based (most likely), then you've found the
correct list.

Just post the series here and we'll offer helpful comments ;-)

Also, please check MAINTAINERS for the directories you are changing and
include the maintainers in the CC: or TO:.  Most likely, that'll be
myself and Andrew Lunn (kirkwood / orion boards).

hth,

Jason.
