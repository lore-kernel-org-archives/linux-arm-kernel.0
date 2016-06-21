From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:17:54 +0200
Subject: [[PATCH v2] 07/11] ARM: EXYNOS: fixup for __raw operations in
 suspend.c
In-Reply-To: <1466504432-24187-8-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-8-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <57692262.1010800@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> Fix the PMU code endian access code to deal with kernels built for
> big endian operation by changing the __raw IO accessors to the
> _relaxed variants.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> ---
>  arch/arm/mach-exynos/suspend.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)


Thanks, applied for v4.8.

Best regards,
Krzysztof
