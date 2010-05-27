From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 27 May 2010 01:57:56 +0100
Subject: [alsa-devel] [PATCH] imx-ssi.c: fix I2S slave setup
In-Reply-To: <1274891873-3704-1-git-send-email-eric@eukrea.com>
References: <1274891873-3704-1-git-send-email-eric@eukrea.com>
Message-ID: <20100527005756.GD22091@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 06:37:53PM +0200, Eric B??nard wrote:
> * without this fix, the waveform on the SSI port are not real
> I2S signal (at least on i.MX27's SSI4)

As I said in reply to your previous patch the current mainline i.MX
driver is not able to master the clocks at all?
