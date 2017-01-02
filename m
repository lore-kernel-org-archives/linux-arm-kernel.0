From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 2 Jan 2017 17:56:54 +0200
Subject: [GIT PULL] ARM: exynos: Late mach/soc for v4.10
In-Reply-To: <5b0e55c8-01db-3f02-3526-2f71f4a73d88@samsung.com>
References: <1482003132-8844-1-git-send-email-krzk@kernel.org>
 <20161230155312.oupgyip7wtqwcuy2@kozik-lap>
 <CGME20170102092044epcas1p3cbe831b7b6528f818b034d73c85dbe7d@epcas1p3.samsung.com>
 <5b0e55c8-01db-3f02-3526-2f71f4a73d88@samsung.com>
Message-ID: <20170102155654.oey6c542vjcqyit2@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 10:20:21AM +0100, Sylwester Nawrocki wrote:
> On 12/30/2016 04:53 PM, Krzysztof Kozlowski wrote:
> > 
> > Any comments on this? I guess it won't come as late-late-4.10, so can
> > you pull it for v4.11?
>  
> >> Sylwester Nawrocki (1):
> >>       ARM: S3C24XX: Add DMA slave maps for remaining s3c24xx SoCs
> 
> We need this patch in v4.10 to avoid possible I2S and MMC regressions
> on selected s3c24xx SoC, since the DMA clients are already modified.
> If the patch goes in only for v4.11 it would be good to mark it for 
> inclusion in v4.10 stable kernels.  

You didn't mention any strict dependencies when sending this patch...
What do you mean by "needing patch in v4.10"? Is the code already
not bisectable? Already broken?

Best regards,
Krzysztof
