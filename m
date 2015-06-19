From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Jun 2015 09:27:04 +0900
Subject: [PATCH v2 7/7] ARM: shmobile: armadillo800eva dts: Add pinctrl
 and gpio-hog for lcdc0
In-Reply-To: <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
 <1434530336-15073-8-git-send-email-geert+renesas@glider.be>
Message-ID: <20150619002703.GC32130@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 10:38:56AM +0200, Geert Uytterhoeven wrote:
> Configure pinctrl and a GPIO-controller board mux for LCD use.
> This allows the armadillo800eva board staging code to enable lcdc0.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert,

As Greg has now taken patches 1 - 6 I have queued this up.
