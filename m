From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 22:00:06 +0800
Subject: [PATCH 2/2] ARM: dts: cfa10036: Change the OLED display to SSD1306
In-Reply-To: <1366624555-5616-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1366624555-5616-1-git-send-email-maxime.ripard@free-electrons.com>
 <1366624555-5616-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130508140004.GC26072@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 11:55:55AM +0200, Maxime Ripard wrote:
> The SSD1307 was used in an early prototype that will never get
> distributed. The final board now has a SSD1306 instead, that has its own
> power generation unit and thus doesn't need any PWM. The panel attached
> to it also changed.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.
