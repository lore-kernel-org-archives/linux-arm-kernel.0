From: ak@linux.intel.com (Andi Kleen)
Date: Wed, 7 Mar 2018 10:54:15 -0800
Subject: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
In-Reply-To: <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
 <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
Message-ID: <20180307185415.GK25017@tassilo.jf.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Sorry about that. That's probably because FNM_EXTMATCH is a GNU extension,
> not POSIX, and the Alpine and Android runtimes likely don't implement
> that...
> I'll send a fix reverting back to the strncmp to ignore the uncore_ prefix,
> and dropping that extension.

Just don't set it? Even the basic glob patterns are useful.

-Andi
