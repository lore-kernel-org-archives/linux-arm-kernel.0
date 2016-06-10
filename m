From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 10 Jun 2016 11:51:16 +0200
Subject: [RFC PATCH 01/15] clock: exynos: fixup endian in pll clk
In-Reply-To: <20160608183110.13851-2-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
 <20160608183110.13851-2-matthew@mattleach.net>
Message-ID: <575A8D94.80709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 08:30 PM, Matthew Leach wrote:
> Fix the clk endian access code to deal with kernels built for big endian
> operation.
> 
> Signed-off-by: Matthew Leach <matthew@mattleach.net>

We should have gotten rid of those __raw_{readl, writel} calls earlier
for other reasons too. Thanks for the fix, patch applied!

-- 
Regards,
Sylwester
