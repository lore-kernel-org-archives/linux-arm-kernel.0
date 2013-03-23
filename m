From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Mar 2013 10:06:02 +0000
Subject: [GIT PULL] sunxi drivers additions for 3.10, take 1
In-Reply-To: <514D7B30.7080002@free-electrons.com>
References: <514D7B30.7080002@free-electrons.com>
Message-ID: <201303231006.02970.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 March 2013, Maxime Ripard wrote:
> Please consider pulling the following pull request that contains
> drivers to be included in 3.10. The only addition for now is the clock
> driver for the Allwinner A10 and A13.
> 

Hi Maxime,

I see the patches have been Acked by Mike Turquette, so I assume he's
ok with getting them merged through the arm-soc tree, but I don't
actually see a reason why it shouldn't just go through his tree.
If there is something I'm missing, that is probably information
that belongs into the tag description.

I don't mind pulling this if there is a good reason, such as later
pull requests for 3.10 depending on it, but I'd prefer to not just
get a pull request for something that is not in my area without
an explanation why that is necessary, and without having the
real subsystem maintainer on Cc.

	Arnd
