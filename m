From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 26 Aug 2014 17:05:27 +0100
Subject: [PATCH 7/9] arm64: Add atomic macros to assembler.h
In-Reply-To: <73d234924f6de3b3b274d5d5648e4bbea6810450.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
 <73d234924f6de3b3b274d5d5648e4bbea6810450.1408736066.git.geoff@infradead.org>
Message-ID: <20140826160526.GJ16482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 08:49:16PM +0100, Geoff Levand wrote:
> Add an assembler macro definition 'atomic' for performing generic
> atomic operations.  Also add macro definitions for atomic_add,
> atomic_sub, atomic_inc, and atomic_dec.

Same question as before. Why are this needed?

-- 
Catalin
