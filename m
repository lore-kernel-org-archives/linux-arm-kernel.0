From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 12:17:01 -0800
Subject: [PATCH v2 18/18] arm64: select ARCH_SUPPORTS_LTO_CLANG
In-Reply-To: <20171116191307.GC3624@linux.vnet.ibm.com>
References: <20171116163054.kcsdsomr7u2mqql2@hirez.programming.kicks-ass.net>
 <CAKwvOdkV_g0XAbGM+nF2zt=2+tHLLcj=pbSxRDd2HMbrtU3cZg@mail.gmail.com>
 <20171116165922.llrojrvomuihabrt@hirez.programming.kicks-ass.net>
 <CAKwvOd=k=iVQvWmzP1E3XHUCYLoJgx+F9zoPuE+R2oaw_ePUVA@mail.gmail.com>
 <20171116173417.nqsh5dpu65uj7b5s@hirez.programming.kicks-ass.net>
 <20171116174830.GX3624@linux.vnet.ibm.com>
 <CAKwvOdkDz1yRo=Skt_mWxs0uucK+adXx8kFQksMbTE3ofnpUMQ@mail.gmail.com>
 <20171116183950.GA3624@linux.vnet.ibm.com>
 <20171116184508.GC21898@arm.com>
 <20171116191307.GC3624@linux.vnet.ibm.com>
Message-ID: <20171116201701.GA143965@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:13:07AM -0800, Paul E. McKenney wrote:
> Ah, if "this patch set" meant "adding LTO", I stand corrected and I
> apologize for my confusion.

Again, I'm not proposing for LTO to be enabled by default. These patches
just make it possible to enable it. Are you saying the possibility
that a future compiler update breaks something is a blocker even for
experimental features?

> I agree that we need LTO/PGO to be housebroken from an LKMM viewpoint
> before it is enabled.

Can you elaborate what's needed from clang before this can move
forward? For example, if you have specific test cases in mind, we can
always work on including them in the LLVM test suite.

Sami
