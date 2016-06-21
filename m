From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:16:09 +0200
Subject: [[PATCH v2] 02/11] ARM: Samsung: fixup endian issues in cpu
 detection
In-Reply-To: <1466504432-24187-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <576921F9.6050807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> If the system is built for big endian, then the cpu identificaiton register
> will be read in the wrong order. Fix this by using readl_relaxed() on the
> register.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/plat-samsung/cpu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)


Thanks, applied for v4.8.

Best regards,
Krzysztof
