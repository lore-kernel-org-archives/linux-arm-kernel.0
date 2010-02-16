From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 15 Feb 2010 17:55:32 -0700 (MST)
Subject: [PATCH 00/13] OMAP: clock: cleanup series for 2.6.34
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1002151754570.28188@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Feb 2010, Paul Walmsley wrote:

> this series, targeted for 2.6.34,
> 
> - fixes several OMAP clock bugs,
> 
> - removes several unnecessary clock structure fields and clock flags,
> 
> - splits the OMAP2420 and OMAP2430 clock trees in preparation for
>   multi-OMAP 2 kernels,
> 
> - and modularizes the OMAP3 chip family-specific clock code so
>   some code and data that is not applicable to a targeted build
>   can be elided during compilation.
> 
> The series has been boot-tested on the OMAP2430 SDP.  Further testing
> is now being undertaken on OMAP5912 OSK, N800 and OMAP3530 Beagle.

This series worked on N800 and Overo after minor changes to two of the 
patches - to follow shortly.


- Paul
