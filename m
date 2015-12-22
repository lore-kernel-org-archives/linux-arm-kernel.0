From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Dec 2015 20:41:30 -0800
Subject: [GIT PULL 1/9] ARM: EXYNOS: dts: Syscon dependency for v4.5
In-Reply-To: <1449020386-20250-2-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
 <1449020386-20250-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151222044130.GB30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 10:39:38AM +0900, Krzysztof Kozlowski wrote:
> Hi Kukjin,
> 
> The DT changes are needed before switching to syscon-based reboot
> and power off method.
> 
> Best regards,
> Krzysztof
> 
> 
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-syscon-restart-4.5
> 
> for you to fetch changes up to 35135f4b95f03be7ebbf31221ce738f1ec0faa02:
> 
>   ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 (2015-11-20 15:58:44 +0900)

Thanks, merged into next/dt.


-Olof
