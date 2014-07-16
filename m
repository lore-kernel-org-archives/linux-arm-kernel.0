From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 16 Jul 2014 13:59:42 +0200
Subject: ARM: shmobile: r7s72100: genmai: CONFIG_MACH_GENMAI
In-Reply-To: <1405509309.4408.36.camel@x220>
References: <1405509309.4408.36.camel@x220>
Message-ID: <1741462.gsq1khyh60@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wednesday 16 July 2014 13:15:09 Paul Bolle wrote:
> Commit bec652e2fbfe ("ARM: shmobile: r7s72100: genmai: Remove legacy
> board file") is included in linux-next as of next-20140716.
> 
> It removed the Kconfig symbol MACH_GENMAI (twice!). It also removed its
> macro from a Makefile. It did not touch its macro from
> arch/arm/mach-shmobile/Makefile.boot.

That was a mistake, sorry.

> Is the trivial patch to remove CONFIG_MACH_GENMAI from that Makefile
> queued somewhere?

Not yet. I've just sent "[PATCH] ARM: shmobile: Remove MACH_GENMAI from 
Makefile.boot" to the linux-sh mailing list.

-- 
Regards,

Laurent Pinchart
