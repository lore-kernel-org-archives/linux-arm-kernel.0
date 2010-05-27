From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 May 2010 03:04:11 +0100
Subject: [PATCH] imx-ssi.c: fix I2S slave setup
In-Reply-To: <1274891873-3704-1-git-send-email-eric@eukrea.com>
References: <1274891873-3704-1-git-send-email-eric@eukrea.com>
Message-ID: <20100527020411.GA26138@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 06:37:53PM +0200, Eric B??nard wrote:
> * without this fix, the waveform on the SSI port are not real
> I2S signal (at least on i.MX27's SSI4)

BTW, please do also remember to CC maintainers on patches as documented
in Documentation/SubmittingPatches.
