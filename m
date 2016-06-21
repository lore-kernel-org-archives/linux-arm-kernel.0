From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:17:45 +0200
Subject: [[PATCH v2] 06/11] ARM: Samsung: fixup usage of __raw IO
In-Reply-To: <1466504432-24187-7-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-7-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <57692259.8090103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> Fix the use of __raw accesors in pm-common.c to use the _relaxed
> variants to deal with any issues due to endian related fetches.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> ---
>  arch/arm/plat-samsung/pm-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Thanks, applied for v4.8.

Best regards,
Krzysztof
