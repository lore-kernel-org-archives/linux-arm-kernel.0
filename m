From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Aug 2013 11:27:52 +0100
Subject: [PATCH] ARM: EXYNOS: Set 64-bit DMA mask for EXYNOS5250
In-Reply-To: <1376042714-26513-1-git-send-email-tushar.behera@linaro.org>
References: <1376042714-26513-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <20130809102752.GP23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 03:35:14PM +0530, Tushar Behera wrote:
> When LPAE is enabled, we need to set 64bit DMA mask bits.

*Please* check the list archives.  I sent during the last 7 days a patch
series which should address this problem.  Unfortunately, it seems almost
no one has looked at it.
