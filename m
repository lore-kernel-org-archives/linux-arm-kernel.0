From: bp@alien8.de (Borislav Petkov)
Date: Tue, 29 Apr 2014 21:02:01 +0200
Subject: [PATCH v6 3/5] devicetree: bindings: Document Krait cache error
 interrupts
In-Reply-To: <20140429103400.GB22015@e102568-lin.cambridge.arm.com>
References: <1396641450-12854-1-git-send-email-sboyd@codeaurora.org>
 <1396641450-12854-4-git-send-email-sboyd@codeaurora.org>
 <20140408153925.GJ30077@pd.tnic>
 <20140429103400.GB22015@e102568-lin.cambridge.arm.com>
Message-ID: <20140429190200.GD22062@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 11:34:00AM +0100, Lorenzo Pieralisi wrote:
> Sorry for the delay in replying. Those cache bindings need an ACK
> to get merged, and were introduced so that idle states can retrieve
> power domain information for caches. I am going to revive the idle
> bindings thread to see what we can/should merge of these bindings as
> things stand, I really hope this won't block the series any further,
> otherwise we can rework the patches so that this series can get in
> first, or simplify my series to allow both to get merged as soon as
> possible without compromising future requirements.

Right, I think this is Stephen's call. AFAIR, the current state of
affairs is for a followup patchset to come up which I can ack for the
EDAC bits and then another maintainer picks the whole thing up.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
