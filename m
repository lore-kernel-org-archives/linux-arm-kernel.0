From: mingo@kernel.org (Ingo Molnar)
Date: Thu, 5 Mar 2015 07:37:12 +0100
Subject: [GIT PULL 00/21] perf/core improvements and fixes
In-Reply-To: <CAA3XUr0LNX0E9kWbrzsTcMMs7ukq-Mt4XDWyQyWDyLfXqtSRTA@mail.gmail.com>
References: <1423688955-8094-1-git-send-email-acme@kernel.org>
 <CAA3XUr0LNX0E9kWbrzsTcMMs7ukq-Mt4XDWyQyWDyLfXqtSRTA@mail.gmail.com>
Message-ID: <20150305063712.GA23109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Victor Kamensky <victor.kamensky@linaro.org> wrote:

> Hi Arnaldo, Ingo,
> 
> What happened with this pull request? [...]

This pull request was for v4.1, and I merged it in:

commit 8a26ce4e544659256349551283414df504889a59
Merge: acba3c7e4652 726f3234dd12
Author: Ingo Molnar <mingo@kernel.org>
Date:   Wed Feb 18 19:14:54 2015 +0100

    Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core
    
    Pull perf/core improvements and fixes from Arnaldo Carvalho de Melo:
    
    User visible changes:

> [...] I already see in v4.0-rc2 changes additions to one requested 
> by this pull request, but I don't see this series itself.
> 
> For example e370a3d57664cd5e39c0b95d157ebc841b568409
> "perf symbols: Define EM_AARCH64 for older OSes" by David
> is already in v4.0-rc2 and it is supposed to be addition to
> "perf symbols: Ignore mapping symbols on aarch64" that is part
> of this pull request but it did not make into v4.0-rcX yet. Looks
> quite strange.

If some commits of the v4.1 queue are needed in v4.0 as well then they 
should be cherry-picked back into the urgent queue.

But maybe e370a3d57 was merged prematurely - in that case it appears 
to be harmless and v4.1 will sort it out.

Arnaldo?

Thanks,

	Ingo
