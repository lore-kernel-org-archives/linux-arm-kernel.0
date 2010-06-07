From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 Jun 2010 14:26:37 +0100
Subject: [alsa-devel] [RFC PATCH v3 0/3] ep93xx i2s audio
In-Reply-To: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
Message-ID: <20100607132634.GE5993@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 04, 2010 at 05:11:22PM +1200, Ryan Mallon wrote:
> The following patch series adds support for i2s audio on the ep93xx,
> with the Snapper CL15 used as an example implementation.

Please do remember to CC maintainers on patches.  I've had to remind you
about this before, it's really not helpful to drop the people you're
expecting to review the patches - it'll tend to delay things or lead to
the patches getting missed.  From a code point of view this looks fine
but we'll need an arch maintainer to sign off on that bit of the code.
I've applied 2/3 since that has no arch/arm elements.
