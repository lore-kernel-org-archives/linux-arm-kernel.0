From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Sep 2014 17:18:33 +0100
Subject: [PATCH v4 6/8] arm64: exynos7: Enable ARMv8 based Exynos7 (SoC)
 support
In-Reply-To: <1410535592-5782-8-git-send-email-ch.naveen@samsung.com>
References: <1410535592-5782-1-git-send-email-ch.naveen@samsung.com>
 <1410535592-5782-8-git-send-email-ch.naveen@samsung.com>
Message-ID: <20140918161832.GD25330@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 04:26:30PM +0100, Naveen Krishna Chatradhi wrote:
> From: Alim Akhtar <alim.akhtar@samsung.com>
> 
> This patch adds the necessary Kconfig entries to enable
> support for the ARMv8 based Exynos7 SoC.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig |   12 ++++++++++++

Please update the defconfig as well as we want the default image build
to contain all the available platforms.

-- 
Catalin
