From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 May 2012 11:12:23 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC6E172.4080601@gmail.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
 <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com> <20120531030016.GB29372@mbp>
 <4FC6E172.4080601@gmail.com>
Message-ID: <20120531031222.GC29372@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 04:11:46AM +0100, bill4carson wrote:
> On 2012?05?31? 11:00, Catalin Marinas wrote:
> > AFAIK, The SCU only snoops the D-cache, not the I-cache. We have a full
> > I-cache invalidation during task migration.
> 
>                              ^^^^^^^^^^^^
> Could you please point it to me?

There is a check in switch_mm() in the asm/mmu_context.h file.

-- 
Catalin
