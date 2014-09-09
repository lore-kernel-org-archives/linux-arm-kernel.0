From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 16:59:07 +0200
Subject: [GIT PULL 2/2] SOCFPGA driver updates for 3.18
In-Reply-To: <1409847105-27241-2-git-send-email-dinguyen@opensource.altera.com>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <1409847105-27241-2-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <3081326.KgOEtsBgKv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 September 2014 11:11:45 dinguyen at opensource.altera.com wrote:
> Hi Arnd, Kevin and Olof,
> 
> Please consider pulling this patch for v3.18. Boris had given me permission to
> take this patch together with it's DTS component. The DTS portion was in the
> previous pull request.

I have no objections to the code, but I don't understand what you gain
from merging it through arm-soc. There is no dependency between the
driver and the dts entries in any way, you just need to have both in order
for things to work.

We can always pull in drivers with permission from the maintainer when there
is a good reason to do that, but I don't see that reason for this patch,
so I'd prefer to have Boris merge it through his tree, unless I'm missing
something.

	Arnd
