From: msalter@redhat.com (Mark Salter)
Date: Tue, 12 Nov 2013 10:55:11 -0500
Subject: [PATCH 00/11] Consolidate asm/fixmap.h files
In-Reply-To: <52824BBC.9020401@monstr.eu>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <52824BBC.9020401@monstr.eu>
Message-ID: <1384271711.24631.5.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-12 at 16:39 +0100, Michal Simek wrote:
> On 11/12/2013 02:22 PM, Mark Salter wrote:
> > 
> >  arch/arm/include/asm/fixmap.h        |  25 ++------
> >  arch/hexagon/include/asm/fixmap.h    |  40 +------------
> >  arch/metag/include/asm/fixmap.h      |  32 +----------
> >  arch/microblaze/include/asm/fixmap.h |  44 +-------------
> >  arch/mips/include/asm/fixmap.h       |  33 +----------
> >  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
> >  arch/sh/include/asm/fixmap.h         |  39 +------------
> >  arch/tile/include/asm/fixmap.h       |  33 +----------
> >  arch/um/include/asm/fixmap.h         |  40 +------------
> >  arch/x86/include/asm/fixmap.h        |  59 +------------------
> >  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++++++++++
> >  11 files changed, 125 insertions(+), 371 deletions(-)
> >  create mode 100644 include/asm-generic/fixmap.h
> 
> Any repo/branch with all these patches will be helpful.

https://github.com/mosalter/linux (fixmap branch)
