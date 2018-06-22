From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Fri, 22 Jun 2018 13:34:47 +0000
Subject: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
In-Reply-To: <20180622092305.GS17671@n2100.armlinux.org.uk>
References: <20180621155906.12821-1-geert+renesas@glider.be>
 <20180622092305.GS17671@n2100.armlinux.org.uk>
Message-ID: <TY1PR01MB1562CCB1FAC3AFA20CDBC9958A750@TY1PR01MB1562.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 22, 2018, Russell King - ARM Linux wrote:
> We've worked around the issues with "multi-platform" XIP/NOMMU by
> using things such as "ARM_SINGLE_V7M" to cover all V7M platforms
> (which must, by definition) have compatible physical layouts.
> Exactly the same approach should be adopted for other XIP/NOMMU
> platforms, and _not_ reusing ARCH_MULTIPLATFORM, which will lead
> to lots of non-bootable kernels.


FYI, I already submitted at patch like that:

https://patchwork.kernel.org/patch/9563975/


Chris
