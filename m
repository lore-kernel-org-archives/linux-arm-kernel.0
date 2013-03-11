From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Mar 2013 00:41:56 +0000 (UTC)
Subject: OMAP4 PM bootloader dependency problems
In-Reply-To: <5111615B.50708@ti.com>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
 <5111615B.50708@ti.com>
Message-ID: <alpine.DEB.2.00.1303110039230.774@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

sorry for the delay,

On Tue, 5 Feb 2013, Jon Hunter wrote:

> I noticed on my OMAP4430 SDP that in suspend L3INIT was failing to enter 
> retention state. I am not sure if this is the same problem that you are 
> seeing or not. However, I found that the reason the L3INIT was not entering
> retention on this board was because the USB DPLL was not locked by the
> bootloader on this board. On my panda the USB DPLL is locked the L3INIT 
> is entering suspend. 
> 
> I crafted the following which is working on my omap4430 panda, sdp and 
> omap4460 panda. Let me know what you think ...

Looks fine to me.  It doesn't fix the problem I'm seeing with OMAP4 
L3INIT, unfortunately.  But it sounds like it fixes a problem for you -- 
which means it probably fixes something for other people too.  Queued
for v3.9-rc.


- Paul
