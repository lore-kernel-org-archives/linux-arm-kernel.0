From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 8 Dec 2010 12:46:31 -0700 (MST)
Subject: [PATCH 01/11] OMAP4: PRCM: add OMAP4-specific
	accessor/mutatorfunctions
In-Reply-To: <3407936b2b482d0f7f6b5bb273455377@mail.gmail.com>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
	<20101208061829.30541.99531.stgit@twilight.localdomain>
	<3407936b2b482d0f7f6b5bb273455377@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1012081243270.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 8 Dec 2010, Rajendra Nayak wrote:

> > +#include "cminst44xx.h"
> 
> This header seems to be missed in the series.

Oops, sorry about that.  Fixed in the git branch on git.pwsan.com.

Attached below is the final mach-omap2/cminst44xx.h file.  It's created by 
the first patch in this series ("OMAP4: PRCM: add OMAP4-specific 
accessor/mutator functions") and modified by the seventh patch in the 
series ("OMAP4: clockdomains: add OMAP4 PRCM data and OMAP4 support")
I will repost those.


- Paul
