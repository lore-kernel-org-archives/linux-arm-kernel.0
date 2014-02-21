From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Feb 2014 17:41:35 +0100
Subject: [PATCH v2 2/2] phy: Select PHY_EXYNOS_DP_VIDEO by default for
 ARCH_EXYNOS
In-Reply-To: <53077DE0.7080108@samsung.com>
References: <1392997802-29050-1-git-send-email-s.nawrocki@samsung.com>
 <1753680.KKj0Q1erxA@wuerfel> <53077DE0.7080108@samsung.com>
Message-ID: <1888663.ccFYmJ9QJl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 February 2014 17:25:04 Sylwester Nawrocki wrote:
> 
> Hmm, good point, I will modify it that way.
> 
> For patch 1/2 I guess it should be:
> 
> "default ARCH_S5PV210 || ARCH_EXYNOS"
> 
> or rather
> 
> "default y if ARCH_S5PV210 || ARCH_EXYNOS" ?

Right. I'd probably use the first syntax, but it doesn't really matter.

	Arnd
