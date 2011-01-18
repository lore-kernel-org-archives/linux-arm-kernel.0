From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Jan 2011 18:28:18 -0000
Subject: [PATCH] arm: Configure reference clock for Versatile
	Express	timers
In-Reply-To: <20110118181840.GH16980@n2100.arm.linux.org.uk>
References: <1295368773-14531-1-git-send-email-pawel.moll@arm.com>
	<20110118174428.GG16980@n2100.arm.linux.org.uk>
	<000001cbb739$ef879490$ce96bdb0$@moll@arm.com>
	<20110118181840.GH16980@n2100.arm.linux.org.uk>
Message-ID: <000101cbb73d$7ab743f0$7025cbd0$@moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The only other reference to "System Controller" is at the beginning
> of the document in the preface: "ARM PrimeCell System Controller
> (SP810) Technical Reference Manual (ARM DDI 0254)".
> 
> DDI0254 is not published, so there's nothing on the register
> layout.

It's exactly the DDI0254 that contains the information, but - as you have pointed out - it's marked as obsolete and not available any more. Don't really know the reason... 

I spent quite a lot of time investigating the problem and it appears that this cell is of little use these days - the only useful function is the timers reference clock muxer. I didn't even know that there the header file with its register offsets exist at all :-) before Will pointed this out...

So - as I said - the named constants are the best I can do.

Cheers!

Pawe?
