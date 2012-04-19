From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 19 Apr 2012 11:22:43 -0700
Subject: [PATCH] arm: omap3: am35x: Register davinci_mdio before
 davinci_emac
In-Reply-To: <1334859578-14446-1-git-send-email-mgreer@animalcreek.com>
References: <1334859578-14446-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <20120419182243.GB14705@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 11:19:38AM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Problem:
> --------
> When resuming from a Suspend-to-RAM event, the eth0 device
> (davinci emac/mdio) on am35xx boards wouldn't work and the
> following error message appeared on the console:
> 
> "net eth0: could not connect to phy davinci_mdio-0:00"

I'm sorry, please ignore.  This patch has already been pooh-pooh'd.

Mark
--
