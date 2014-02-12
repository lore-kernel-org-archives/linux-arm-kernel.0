From: mingo@kernel.org (Ingo Molnar)
Date: Wed, 12 Feb 2014 12:27:44 +0100
Subject: [PATCH] perf: ARM64: wire up perf_regs and unwind support
In-Reply-To: <20140212101011.GC13441@mudshark.cambridge.arm.com>
References: <1391451427-31221-1-git-send-email-jean.pihet@linaro.org>
 <CAFrcx1kApRNN7aKQr89Y51w_JqUhVZ2x4+a8Sx8-X7xb-a1=pw@mail.gmail.com>
 <20140212101011.GC13441@mudshark.cambridge.arm.com>
Message-ID: <20140212112744.GA10517@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Feb 12, 2014 at 08:46:38AM +0000, Jean Pihet wrote:
> > Hi Arnaldo, Will,
> > 
> > Ping on this patch.
> 
> This needs to go via the perf tree to avoid a repeat of the mess last time.

If the tooling bits are fine with Arnaldo then I have no objections 
either - once all the bits are acked please send a single series with 
all 4(?) patches in it, for tip:perf/core inclusion.

Thanks,

	Ingo
