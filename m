From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 9 Oct 2013 18:59:53 +0000 (UTC)
Subject: [PATCHv7 00/36] ARM: OMAP: clock data conversion to DT
In-Reply-To: <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
References: <1380098922-30340-1-git-send-email-t-kristo@ti.com>
 <524EE00F.7010208@ti.com> <20131007021556.GV8949@atomide.com>
 <52525642.8010307@ti.com> <20131007154103.GW8949@atomide.com>
 <20131007190322.GY8949@atomide.com>
 <alpine.DEB.2.02.1310091551540.30199@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1310091858411.30199@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eh, one correction:

On Wed, 9 Oct 2013, Paul Walmsley wrote:

> We could easily wind up with kernels that won't boot at all when used 
> with newer DT data.

This is a misstatement of the issue: the concern here is that newer 
kernels may not boot at all with older DT data - which could easily be in 
locked areas of the flash or firmware.


- Paul
