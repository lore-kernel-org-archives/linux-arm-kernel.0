From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 May 2016 09:34:11 +0900
Subject: [PATCH v2 00/23] ARM/arm64: dts: renesas: Fix W=1 dtc warnings
In-Reply-To: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
References: <1463728214-13838-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160524003410.GC2477@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 09:09:51AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus, Morimoto-san, Rob,
> 
> This patch series fixes the new warnings related to Renesas arm32/arm64
> DTSes that can be seen in -next using "make W=1 dtbs", courtesy of
> commit b993734718c01064 ("scripts/dtc: Update to upstream version
> 53bf130b1cdd") in Rob herring's for-next branch. For testing, you can just
> cherry-pick that commit (showing the warning for W=1 only was a separate
> commit).

Thanks, I have queued this up.
