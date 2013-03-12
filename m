From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 12 Mar 2013 14:17:46 +0100
Subject: [PATCH 1/7] clk: samsung: add plls used in s3c2416 and s3c2443
In-Reply-To: <201303121321.34338.heiko@sntech.de>
References: <201303120141.31262.heiko@sntech.de>
 <201303120142.19842.heiko@sntech.de> <513F1B42.7000201@samsung.com>
 <201303121321.34338.heiko@sntech.de>
Message-ID: <513F2AFA.6030804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 01:21 PM, Heiko St?bner wrote:
> Thanks for the hint ... this is what I rightfully get for mindlessly copying 
> from the other plls in the file;-) .

:)

> What about the other plls in the pll-file, they should be affected in the same 
> way, right?

Yes, they're of course also affected. Otherwise we wouldn't know about
the problem;) We are going to submit all fixes we have for the clk driver
shortly. But those are mostly for the Exynos clocks definitions.
