From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jan 2014 15:56:43 +0000
Subject: [PATCH] ARM: shmobile: compile drivers/sh for
 CONFIG_ARCH_SHMOBILE_MULTI
In-Reply-To: <1482392.XFeYNLvUZH@avalon>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140120125436.GN17314@sirena.org.uk>
 <52DD224B.1050502@codethink.co.uk> <1482392.XFeYNLvUZH@avalon>
Message-ID: <20140120155643.GQ17314@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 04:48:10PM +0100, Laurent Pinchart wrote:

> The problem isn't as simple as it seems, and more advanced implementations 
> that would allow listing clocks that should be managed automatically (or the 
> other way around) would also add another level of complexity. The required 
> information is platform-dependent, but we currently don't express it as such 
> in DT.

Well, the set of clocks an IP requires will tend to be the same - it's
normally just that integrators may have done things like tie them
together or decide to spread confusion by renaming them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/4673e8f6/attachment.sig>
