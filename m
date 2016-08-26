From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 Aug 2016 17:30:26 -0700
Subject: [GIT PULL] ARM: exynos: Fixes for v4.8
In-Reply-To: <1471501915-4746-1-git-send-email-k.kozlowski@samsung.com>
References: <1471501915-4746-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160826003026.GB8515@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 08:31:55AM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> A fix and a maintainers update for current release cycle (v4.8).
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
> 
>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-fixes-4.8
> 
> for you to fetch changes up to 326dce0734b63c3b82b6a88e5645eab8b54c6692:
> 
>   MAINTAINERS: Switch to kernel.org account for Krzysztof Kozlowski (2016-08-17 17:54:56 +0200)
> 
> ----------------------------------------------------------------
> Fix for v4.8-rc1:
> 1. Select proper eMMC HighSpeed mode on Odroid XU.  DTS was mixing
>    "samsung,exynos5250-dw-mshc" compatible (with HS200 as fastest mode)
>    with a property "mmc-hs400-1_8v" thus leading to failures during
>    probe.
> 
> 2. Update Krzysztof Kozlowski's email address in maintainers.

Merged, thanks.


-Olof
