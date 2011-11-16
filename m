From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Nov 2011 16:07:43 +0000
Subject: [alsa-devel] [PATCH] ARM: pxa: add support for Raumfeld DDX
In-Reply-To: <20111116150722.GA15580@sig21.net>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
 <20111115141348.GG3077@opensource.wolfsonmicro.com>
 <4EC3B30F.60403@gmail.com> <20111116150722.GA15580@sig21.net>
Message-ID: <20111116160742.GH29986@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 04:07:22PM +0100, Johannes Stezenbach wrote:

> IIRC the PXA can handle 24bit audio, and the STA32x can handle it, too.
> However due to constraints in the clock ratios on the Raumfeld board
> this mode cannot be used.  Thus this constraint is in sound/soc/pxa/raumfeld.c.

If that's the case then the comment needs to be updated as currently
what it says is that this is a CPU side limitation.
