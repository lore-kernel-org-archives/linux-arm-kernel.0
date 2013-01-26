From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Jan 2013 10:05:42 +0000
Subject: [PATCHv2 00/19] ARM: common warning fixes
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <20130126100542.GC23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 10:43:59PM +0000, Arnd Bergmann wrote:
> I will get to those once this series is sorted out.
> Since there are no interdepencies between the patches,
> my preference is to have them applied by the individual
> subsystem maintainers. Anything that has not at
> least made it into linux-next by the next merge window
> and has not received a 'NAK' or been obsoleted by
> another patch, I plan to submit as part of an arm-soc
> branch for 3.9.

And, last night we have new warnings.  My allnoconfigs no longer build
cleanly because of new vexpress section mismatches in the mfd code.

It seems to me that you're on a loosing battle unless you test the tree
and drop code _before_ propaging it out if it adds new warnings... force
the pain of these warnings down on to others so that they learn to create
better code in the first place.
