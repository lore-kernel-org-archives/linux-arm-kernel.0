From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Aug 2011 13:28:05 +0200
Subject: [PATCH v3 2/4] msm_serial: Add devicetree support
In-Reply-To: <1313688345-17699-3-git-send-email-davidb@codeaurora.org>
References: <1313688345-17699-1-git-send-email-davidb@codeaurora.org>
	<1313688345-17699-3-git-send-email-davidb@codeaurora.org>
Message-ID: <201108251328.05689.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, David Brown wrote:
> Add devicetree support to the msm_serial driver.  Clocks are still
> queried by direct name from the driver until device tree clock support
> is implemented.
> 
> Signed-off-by: David Brown <davidb@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
