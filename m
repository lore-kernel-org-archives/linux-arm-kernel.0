From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 25 Oct 2011 10:39:28 +0200
Subject: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
In-Reply-To: <20111025083301.GD4605@ponder.secretlab.ca>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20111025083301.GD4605@ponder.secretlab.ca>
Message-ID: <20111025083928.GC31508@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 10:33:01AM +0200, Grant Likely wrote:

> (not that I've actually tested this much yet; it should probably go
> into a separate branch to marinate in linux-next for a bit without
> impacting the other GPIO patches I've got queued.

Yes, it should.  I've test built a few configurations covering both
asm/gpio.h and default implementations and it seems to be doing the
right thing but I might well have missed something.  I'm hoping to also
have a further patch to go on top of this which makes _OPTIONAL_GPOILIB
on by default.
