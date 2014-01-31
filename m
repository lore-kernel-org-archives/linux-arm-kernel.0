From: w@1wt.eu (Willy Tarreau)
Date: Fri, 31 Jan 2014 18:25:25 +0100
Subject: [PATCH v5 00/20] Armada 370/XP watchdog support
In-Reply-To: <20140129181949.GB27143@localhost>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140129181949.GB27143@localhost>
Message-ID: <20140131172525.GL31190@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> > A new round, mostly fixing some minor nitpicks.
> > 
> 
> If anyone wants to give this a test, here's a public branch:
> 
> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5

Tested-By: Willy Tarreau <w@1wt.eu>

Works like a charm on the mirabox, I've long been missing a hardware
watchdog to save me from unplugging the power cord after some hangs
during development.

Thanks,
Willy
