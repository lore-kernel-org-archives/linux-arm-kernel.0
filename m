From: dianders@chromium.org (Doug Anderson)
Date: Tue, 25 Aug 2015 15:08:07 -0700
Subject: [PATCH] ARM: probes: Don't stop the machine if we're in the
 debugger
In-Reply-To: <55DBB48E.7040508@codeaurora.org>
References: <1440460739-19522-1-git-send-email-dianders@chromium.org>
 <55DBB48E.7040508@codeaurora.org>
Message-ID: <CAD=FV=WDJ3-QimHA56nc3rg7T_aGqW2kw+BBW7zMye_6VfqeVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 24, 2015 at 5:19 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Can you add the backtrace?

Good point.  Done.

> Perhaps it would be better to add a different function for the kgdb call
> site? Then it's explicit what's going on without us having to figure out
> when in_dbg_master() is true.

Actually, there was already a function to patch the text directly
without stopping the machine.  :)

Adding a bit of extra noise here to point to my new patch since it has
a very different title than this one (so might be hard to find).  See
<https://patchwork.kernel.org/patch/7073441/>.

-Doug
