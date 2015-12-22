From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Dec 2015 20:49:26 -0800
Subject: [GIT PULL 4/9] ARM64: EXYNOS: Soc specific code for v4.5
In-Reply-To: <1449020386-20250-5-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
 <1449020386-20250-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151222044926.GE30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 10:39:41AM +0900, Krzysztof Kozlowski wrote:
> Hi Kukjin,
> 
> ARM64 change touch also defconfig.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc64-4.5
> 
> for you to fetch changes up to db44c07a3f0b32815bd1f3e731db9e043e57cf9c:
> 
>   arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS (2015-11-22 19:31:30 +0900)

Given that Arnd started splitting out config64 separately, there's a small
chance we'll get a conflict here. We can deal with that if needed though.

Still, since this branch contains the previous clock branch I can't apply it
as it is. Can you respin without that for now?


-Olof
