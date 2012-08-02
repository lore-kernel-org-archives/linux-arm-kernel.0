From: olof@lixom.net (Olof Johansson)
Date: Thu, 2 Aug 2012 10:12:18 -0700
Subject: [PATCH] ARM: PRIMA2: delete redundant codes to restore LATCHED
 when timer resumes
In-Reply-To: <1343626170-27831-1-git-send-email-Barry.Song@csr.com>
References: <1343626170-27831-1-git-send-email-Barry.Song@csr.com>
Message-ID: <20120802171218.GB26795@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 01:29:30PM +0800, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
> 
> The only way to write LATCHED registers to write LATCH_BIT to LATCH register,
> that will latch COUNTER into LATCHED.e.g.
> writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base +
> 	SIRFSOC_TIMER_LATCH);
> 
> Writing values to LATCHED registers directly is useless at all.
> 
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Based on off-list email, applied to fixes.


Thanks,

-Olof
