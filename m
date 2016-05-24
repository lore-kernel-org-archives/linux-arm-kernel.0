From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 May 2016 09:35:19 +0100
Subject: [PATCH 2/4] ARM: dma-mapping: Constify attrs passed to internal
 functions
In-Reply-To: <1464071290-15948-3-git-send-email-k.kozlowski@samsung.com>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
 <1464071290-15948-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160524083519.GC19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 08:28:08AM +0200, Krzysztof Kozlowski wrote:
> Some of the non-exported functions do not modify passed dma_attrs so the
> pointer can point to const data.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
