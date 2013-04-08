From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 08 Apr 2013 22:03:03 +0200
Subject: [PATCH] ARM i.MX53: remove platform ahci support
In-Reply-To: <1365450363-6582-1-git-send-email-s.hauer@pengutronix.de>
References: <1365431039.1830.102.camel@x61.thuisdomein>
 <1365450363-6582-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1365451383.1830.135.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-08 at 21:46 +0200, Sascha Hauer wrote:
> Paul, with this one applied you could also remove config ARCH_MX53.

Unless I'm doing something wrong, this doesn't apply onto v3.9-rc6. I
guess it requires some other branch. But, assuming I don't get fed up
with cleaning up Kconfig cruft, I will notice ARCH_MX53 getting unused
when your patch hits mainline anyway.

But is there a reason you can't just remove ARCH_MX53 yourself?


Paul Bolle
