From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Apr 2016 12:05:39 +0100
Subject: [PATCH 2/3 v2] arm64: defconfig: enable 48-bit virtual addresses
In-Reply-To: <1461167854-3244-1-git-send-email-stuart.yoder@nxp.com>
References: <1461167854-3244-1-git-send-email-stuart.yoder@nxp.com>
Message-ID: <20160422110539.GH2998@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2016 at 10:57:34AM -0500, Stuart Yoder wrote:
> Some armv8 SoCs (e.g. ls2080a) have physical memory maps with discontiguous
> DDR regions that require 48-bit VA to have the linear map cover the entire
> range of DDR.
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
