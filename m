From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Dec 2015 20:46:36 -0800
Subject: [GIT PULL 3/9] ARM64: EXYNOS: clk: Clock dependency for ARM64
 for v4.5
In-Reply-To: <1449020386-20250-4-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
 <1449020386-20250-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151222044636.GD30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 10:39:40AM +0900, Krzysztof Kozlowski wrote:
> Hi Kukjin,
> 
> Dependency for soc64 changes.
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
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-arm64-symbols-4.5
> 
> for you to fetch changes up to 8c2a90ed18a74e8b9cdbba679403faa44d6024fc:
> 
>   clk: samsung: Don't build ARMv8 clock drivers on ARMv7 (2015-11-22 19:25:29 +0900)

Hi,

Looks like this lacks ack from any of the clock maintainers.

Given that EXYNOS_ARM64_COMMON_CLK is not yet introduced, this will cause
a breakage in bisectability on some of these platforms as well.

I'll hold off on this one for a bit.


-Olof
