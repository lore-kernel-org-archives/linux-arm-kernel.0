From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 Aug 2017 18:39:14 +0100
Subject: [PATCHv2 00/14] arm64: VMAP_STACK support
In-Reply-To: <fa283afb-b611-45da-a89a-12fafe987082@redhat.com>
References: <1502801449-29246-1-git-send-email-mark.rutland@arm.com>
 <fa283afb-b611-45da-a89a-12fafe987082@redhat.com>
Message-ID: <20170815173913.GA27057@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 10:18:20AM -0700, Laura Abbott wrote:
> On 08/15/2017 05:50 AM, Mark Rutland wrote:
> > Hi,
> > 
> > Ard and I have worked together to implement vmap stack support for
> > arm64. This supersedes our earlier vmap stack RFCs [0,1]. The git author
> > stats are a little misleading, as I've teased parts out into smaller
> > patches for review.
> > 
> > The series is based on our stack dump rework [2,3], which can be found
> > in the arm64/exception-stack branch [4] of my kernel.org repo. This
> > series can be found in the arm64/vmap-stack branch [5] of the same repo.

> Tested-by: Laura Abbott <labbott@redhat.com>

Thanks!

> (I think I may be slightly late with this. Oh well.)

On the chance that Catalin's happy to redo the pull, I've folded that
Tested-by in, and pushed the series.

Thanks,
Mark.
