From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2016 10:39:47 +0100
Subject: [PATCH] ARM: cacheflush: Remove unused secure_flush_area API
In-Reply-To: <1471673221-19181-1-git-send-email-andy.gross@linaro.org>
References: <1471673221-19181-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20160823093947.GF1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 01:07:01AM -0500, Andy Gross wrote:
> This patch removes the unused secure_flush_area function.  The only
> consumer of this function has moved to using the streaming DMA APIs.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Looks fine, and from what I can see, nothing depends on it in mainline,
so please put it in the patch system.  Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
