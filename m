From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 22:01:02 +0800
Subject: [PATCH 1/4] ARM: cfa10036: dt: Change i2c0 clock frequency
In-Reply-To: <1366624945-5708-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
 <1366624945-5708-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130508140101.GD26072@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 12:02:22PM +0200, Maxime Ripard wrote:
> The OLED display can work faster. Change the i2c controller clock
> frequency to remove the tearing effect that can be seen on the display.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.
