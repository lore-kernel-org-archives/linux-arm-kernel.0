From: geoff@infradead.org (Geoff Levand)
Date: Tue, 26 Aug 2014 12:40:53 -0700
Subject: [PATCH 7/9] arm64: Add atomic macros to assembler.h
In-Reply-To: <20140826160526.GJ16482@arm.com>
References: <cover.1408736066.git.geoff@infradead.org>
 <73d234924f6de3b3b274d5d5648e4bbea6810450.1408736066.git.geoff@infradead.org>
 <20140826160526.GJ16482@arm.com>
Message-ID: <1409082053.11425.43.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Tue, 2014-08-26 at 17:05 +0100, Catalin Marinas wrote:
> On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> > Add an assembler macro definition 'atomic' for performing generic
> > atomic operations.  Also add macro definitions for atomic_add,
> > atomic_sub, atomic_inc, and atomic_dec.
> 
> Same question as before. Why are this needed?

I use these in the smp-spin-table re-work I am doing to keep a
count of CPUs in the secondary_holding_pen, but those patches
are not yet ready for review.

I thought I'd post this now thinking theses macros might be of use
to someone else.  I could just put them into the smp-spin-table
series, please let me know.

-Geoff
