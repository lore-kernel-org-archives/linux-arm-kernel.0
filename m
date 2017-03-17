From: tj@kernel.org (Tejun Heo)
Date: Fri, 17 Mar 2017 09:39:00 -0400
Subject: [PATCH] pata_pcmcia: add EBSA110's PCMCIA slot support
In-Reply-To: <1533391.BtkrkgvqUW@amdc3058>
References: <CGME20170314175046epcas1p43f98daad14a2bac7f314e7d39e120232@epcas1p4.samsung.com>
 <3458240.9SL7iGif3L@amdc3058>
 <20170316212654.GD1480@htj.duckdns.org>
 <1533391.BtkrkgvqUW@amdc3058>
Message-ID: <20170317133900.GA5078@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Mar 17, 2017 at 12:59:56PM +0100, Bartlomiej Zolnierkiewicz wrote:
> There is no support for this device in the upstream ide driver but
> Russell has a hacky patch to make it work by redefining inb()/outb()
> operations globally for the whole ide subsystem, please see:
> 
> https://www.spinics.net/lists/arm-kernel/msg567454.html

Well, that mail says that the hardware is a museum piece.  What's the
point here?  This can't even be tested, can it?

Thanks.

-- 
tejun
