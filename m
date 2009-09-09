From: jsgood.yang@samsung.com (Jinsung Yang)
Date: Wed, 09 Sep 2009 18:22:43 +0900
Subject: ARM Cortex-based multi-core support?
In-Reply-To: <1252486591.24414.1.camel@pc1117.cambridge.arm.com>
References: <008d01ca3128$0b012e00$21038a00$%yang@samsung.com>
	<1252486591.24414.1.camel@pc1117.cambridge.arm.com>
Message-ID: <000601ca312f$16046090$420d21b0$%yang@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you Catalin,

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Wednesday, September 09, 2009 5:57 PM
> To: Jinsung Yang
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: ARM Cortex-based multi-core support?
> 
> On Wed, 2009-09-09 at 17:32 +0900, Jinsung Yang wrote:
> > I'm researching that the latest kernel can support ARM cortex based
> > multi-core platform..
> > First, just I need to know current status.. someone knows?
> 
> AFAICT, it's all supported and works fine (with a few minor issues like
> the recent thread on non position-independent dynamic shared objects, if
> your toolchain generates such things).
> 

Which platform codes are valuable for reference in the mainline?
--
Jinsung Yang
