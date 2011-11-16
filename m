From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Nov 2011 17:30:34 +0000
Subject: [PATCH 1/5] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <20111116172815.GF2073@localhost.localdomain>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-2-git-send-email-pawel.moll@arm.com>
 <20111116153516.GB2073@localhost.localdomain>
 <1321460205.3137.352.camel@hornet.cambridge.arm.com>
 <20111116172815.GF2073@localhost.localdomain>
Message-ID: <1321464634.3137.382.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 17:28 +0000, Dave Martin wrote:
> > > Is there anything else blocking the building of legacy and RS1 memory
> > > maps into a single kernel?
> > > (I'm still hazy on how all the remapping stuff works, myself.)
> > 
> > This works now - I have a single binary kernel that works on both A9 and
> > A5 coretiles. Of course the ATAG-based support works with A9 only.
> 
> Cool -- we should get Ryan and Tixy to try it out, if they haven't already.
> I don't have an A5 handy...

Good idea. I'll send them instructions how to boot "DT-enabled" kernel
using Boot Monitor tomorrow and ask to try the series.

Cheers!

Pawe?
