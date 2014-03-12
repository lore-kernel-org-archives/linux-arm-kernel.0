From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Mar 2014 17:45:20 +0000
Subject: [PATCH] perf: ARM64: wire up perf_regs and unwind support
In-Reply-To: <CAFrcx1=ZBWt1mak_6+=KbCFZEsaD3T_xZ8up4WBLSr6_JTkP1A@mail.gmail.com>
References: <1392311193-21214-1-git-send-email-jean.pihet@linaro.org>
 <CAFrcx1=ZBWt1mak_6+=KbCFZEsaD3T_xZ8up4WBLSr6_JTkP1A@mail.gmail.com>
Message-ID: <20140312174520.GB17308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 01:42:51PM +0100, Jean Pihet wrote:
> Hi,
> 
> On 13 February 2014 18:06, Jean Pihet <jean.pihet@linaro.org> wrote:
> > This patch hooks in the perf_regs and libunwind code for ARM64.
> > The tools/perf/arch/arm64 is created; it contains the arch specific
> > code for DWARF unwinding.
> >
> > Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Ping on this patch. Can this one go into the perf tree?

I'm happy to take it as well if there are no objections from the perf
maintainers.

-- 
Catalin
