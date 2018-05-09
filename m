From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 9 May 2018 17:44:28 +0100
Subject: [PATCH 1/2] ARM: dts: Restructure Vexpress motherboard includes
In-Reply-To: <20180427185404.19205-1-linus.walleij@linaro.org>
References: <20180427185404.19205-1-linus.walleij@linaro.org>
Message-ID: <f8bf7e48-72ab-8749-5d23-32346475a440@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/04/18 19:54, Linus Walleij wrote:
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
> 

Please copy me and Lorenzo also in future.
Applied now(with typo in hierarchy fixed), thanks.

-- 
Regards,
Sudeep
