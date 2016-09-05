From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Sep 2016 14:07:54 +0200
Subject: [PATCH] ARM: dts: wheat: add SDHI0 support
In-Reply-To: <0defa744-2a9e-ee50-6212-589cee7e537f@cogentembedded.com>
References: <34968644.DhifNderY8@wasted.cogentembedded.com>
 <1659137.gEKJxNrmrk@wasted.cogentembedded.com>
 <0defa744-2a9e-ee50-6212-589cee7e537f@cogentembedded.com>
Message-ID: <20160905120754.GD24256@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 04, 2016 at 12:49:12AM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 08/31/2016 01:24 AM, Sergei Shtylyov wrote:
> 
> >Define the Wheat board dependent  part of  the SDHI0 (connected to the
> >micro-SD slot)  device node along with the necessary voltage regulator.
> >
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up.

> >---
> >This patch is against the 'renesas-devel-20160830-v4.8-rc4' of Simon Horman's
> >'renesas.git' repo plus the CAN patch posted yesterday.
> >Starting with this patch, SMSC LAN89218 Ethernet chip starts to misbehave on my
> >board...
> 
>    Fortunately, this ill effect has been fixed by Jeremy Lintion's smsc911x
> driver patches that should hit Linus' tree soon (they're alredy in DaveM's
> net.git)...
