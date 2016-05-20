From: horms@verge.net.au (Simon Horman)
Date: Fri, 20 May 2016 13:30:25 +0900
Subject: [PATCH 00/23] ARM/arm64: dts: renesas: Fix W=1 dtc warnings
In-Reply-To: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
References: <1463126163-29423-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160520043025.GI25184@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Fri, May 13, 2016 at 09:55:40AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus, Morimoto-san, Rob,
> 
> This patch series fixes the new warnings related to Renesas arm32/arm64
> DTSes that can be seen in -next using "make W=1 dtbs", courtesy of
> commit b993734718c01064 ("scripts/dtc: Update to upstream version
> 53bf130b1cdd") in Rob herring's for-next branch. They're all of the
> form:

I am fine with these changes. Would you care to repost after addressing
the minor feedback they have received (mostly from yourself).
