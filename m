From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 29 May 2018 10:25:05 +0100
Subject: [PATCH 1/4] ARM: dts: Restructure Vexpress motherboard includes
In-Reply-To: <20180528122658.3241-2-linus.walleij@linaro.org>
References: <20180528122658.3241-1-linus.walleij@linaro.org>
 <20180528122658.3241-2-linus.walleij@linaro.org>
Message-ID: <326b8b98-4f1b-926a-8124-177381368a2c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 28/05/18 13:26, Linus Walleij wrote:
> It is a bit unorthodox to just include a file in the middle
> of a another DTS file, it breaks the pattern from other device
> trees and also makes it really hard to reference things
> across the files with phandles.
> 
> Restructure the include for the Versatile Express motherboards
> to happen at the top of the file, reference the target nodes
> directly, and indent the motherboard .dtsi files to reflect
> their actual depth in the hiearchy.
> 
> This is a purely syntactic change that result in the same
> DTB files from the DTS/DTSI files.
Is it different from v1/earlier version you had posted ?
I have already sent this to ARM SoC and it should be in -next by now.
I will add the remaining 3 patches for v4.19 once you confirm
that I can drop this patch as it's already queued.

-- 
Regards,
Sudeep
