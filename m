From: jolsa@redhat.com (Jiri Olsa)
Date: Mon, 28 Apr 2014 11:24:15 +0200
Subject: [PATCH] perf: ARM64: wire up perf_regs and unwind support
In-Reply-To: <CAFrcx1mvSMFea999FZCEVxMZsmyFw+b_fugdGSEsAJkqwzkXQw@mail.gmail.com>
References: <1392311193-21214-1-git-send-email-jean.pihet@linaro.org>
 <CAFrcx1=ZBWt1mak_6+=KbCFZEsaD3T_xZ8up4WBLSr6_JTkP1A@mail.gmail.com>
 <20140312174520.GB17308@arm.com>
 <20140313101202.GB11365@mudshark.cambridge.arm.com>
 <20140313102203.GC30339@arm.com>
 <CAFrcx1mZg-kdBG2d4bwWdqJByYXLG2SJ5+GD7cSteqJj=A6Sxw@mail.gmail.com>
 <CAFrcx1mvSMFea999FZCEVxMZsmyFw+b_fugdGSEsAJkqwzkXQw@mail.gmail.com>
Message-ID: <20140428092415.GA1109@krava.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:15:43AM +0200, Jean Pihet wrote:
> Arnaldo,
> 
> > This patch hooks in the perf_regs and libunwind code for ARM64.
> > The tools/perf/arch/arm64 is created; it contains the arch specific
> > code for DWARF unwinding.
> >
> > Signed-off-by: Jean Pihet <jean.pihet@linaro.org>
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Ping on this patch. Can you take this patch in your tree?
> Please let me know if you need a rebased version of this one.

I'll check this one

jirka
