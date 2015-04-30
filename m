From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Apr 2015 09:14:51 +0900
Subject: [PATCH 0/5] ARM: shmobile: dts: Add "nor-jedec" compatible value
In-Reply-To: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
References: <1430215978-31087-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150430001450.GD17758@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 12:12:53PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the "nor-jedec" compatible value to all device
> nodes for JEDEC-compliant SPI FLASHes on Renesas shmobile boards,
> It allows the driver to bind against the generic name, cfr. commit
> 8ff16cf77ce314c2 ("Documentation: devicetree: m25p80: add "nor-jedec"
> binding").
> 	        
> This was tested on r8a7791/koelsch. I verified that it also works with
> "nor-jedec" only, without the specific compatible value.
> 
> Thanks for applying!

Thanks, I have queued these up for v4.2.
