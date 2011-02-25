From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 Feb 2011 22:03:28 -0700 (MST)
Subject: [PATCH 0/3] OMAP2+: voltage: first pass at cleanup/reorganization
In-Reply-To: <553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<553cd99ec29ee91e4a4b324d0f4a0be7@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102242201410.6198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On Thu, 24 Feb 2011, Rajendra Nayak wrote:

> I found these abort on my 4430SDP. The below changes I found
> are needed for it to bootup..
> I tested the 'integration-2.6.39' branch of
> git://git.pwsan.com/linux-integration and the patch is
> based on this branch.

Thanks very much for the patch, this looks right.  Do you mind if I fold 
it into the "OMAP2+: voltage: reorganize, split code from data" patch and 
credit you appropriately in the patch description?  (That way, there won't 
be any gaps between patches where OMAP4 won't work.)


- Paul
