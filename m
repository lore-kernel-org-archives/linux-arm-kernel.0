From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 May 2010 15:41:12 +0100
Subject: ARM A9 MPCore support in OProfile ?
In-Reply-To: <AANLkTimc70m7gVpPxf01qTD3O6Y63gGwrF76RBlABfsR@mail.gmail.com>
References: <AANLkTimc70m7gVpPxf01qTD3O6Y63gGwrF76RBlABfsR@mail.gmail.com>
Message-ID: <1273502472.10282.60.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-10 at 12:29 +0100, Aneesh Bhasin wrote:
> Had sent this to the oprofile-list too, but did not get any reply.
> Hopefully, someone here who has experience with this could help..
> 
> Can someone please tell what is the status of support for ARM A9
> MPCore PMU in OProfile ?
> 
> I was browsing the linux-arm repository at
> 
> http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=summary
> 
> and could see that it has support for A9 MPCore but could not find
> anything related to it in the OProfile source-code (e.g .in
> events/arm). Is there any patch that needs to be applied to use A9
> MPCore PMU with OProfile ?

The Oprofile patches (by Will Deacon) are in Russell's devel tree and
intended for upstream merge:

http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/devel

My stable repository has some old Oprofile implementation (it requires
additional patches for user space - I can dig them out if you really
need them but I would recommend Will's version).

-- 
Catalin
