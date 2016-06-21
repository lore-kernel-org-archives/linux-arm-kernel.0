From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:15:53 +0200
Subject: [[PATCH v2] 01/11] ARM: EXYNOS: fixup debug macros for big-endian
In-Reply-To: <1466504432-24187-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <576921E9.5090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> The exynos low-level debug macros need to be fixed if the system is being
> built big endian. Add the necessary endian swaps for accessing the registers
> to get output working again
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/debug/samsung.S | 8 ++++++++
>  1 file changed, 8 insertions(+)

Thanks, applied for v4.8.

Best regards,
Krzysztof
