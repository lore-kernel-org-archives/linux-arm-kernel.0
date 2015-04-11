From: slash.tmp@free.fr (Mason)
Date: Sat, 11 Apr 2015 15:45:29 +0200
Subject: Guarantee udelay(N) spins at least N microseconds
In-Reply-To: <20150411121049.GM12732@n2100.arm.linux.org.uk>
References: <20150410114415.GC12732@n2100.arm.linux.org.uk>
 <5527C501.2040808@free.fr> <20150410150607.GG12732@n2100.arm.linux.org.uk>
 <5527EC90.9050900@free.fr> <20150410160817.GH12732@n2100.arm.linux.org.uk>
 <55282C1F.3000600@free.fr> <20150410204221.GI12732@n2100.arm.linux.org.uk>
 <55283F30.7030109@free.fr> <20150411073022.GJ12732@n2100.arm.linux.org.uk>
 <55290C18.8070301@free.fr> <20150411121049.GM12732@n2100.arm.linux.org.uk>
Message-ID: <55292579.1070903@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2015 14:10, Russell King - ARM Linux wrote:

> What this also means is that if you only have a 90kHz counter
> available, doing DVFS is also a stupid idea.

I must be missing something, because I don't see why DVFS
(i.e. saving energy when the system is idle) is a stupid
idea when only a 90 kHz counter is available?

What's the connection?
