From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Date: Tue, 8 Oct 2013 11:28:30 -0300
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of
 dwarf parsing feature
In-Reply-To: <CAFrcx1kNONpBcsEHX1PN0kNUCOAkBCid+bgbv3mc0TPu=F+MYg@mail.gmail.com>
References: <1380195398-4402-1-git-send-email-jean.pihet@linaro.org>
 <1380195398-4402-4-git-send-email-jean.pihet@linaro.org>
 <20130926124829.GA3284@krava.brq.redhat.com>
 <CAFrcx1nDe6mhxEuU4ROJGOmGFaYtVnnhXYirkmhRb1NEecNhtw@mail.gmail.com>
 <20131008104740.GU3081@twins.programming.kicks-ass.net>
 <CAFrcx1kNONpBcsEHX1PN0kNUCOAkBCid+bgbv3mc0TPu=F+MYg@mail.gmail.com>
Message-ID: <20131008142830.GI4018@ghostprotocols.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Oct 08, 2013 at 04:15:40PM +0200, Jean Pihet escreveu:
> On 8 October 2013 12:47, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Oct 08, 2013 at 12:44:32PM +0200, Jean Pihet wrote:
> >> On 26 September 2013 14:48, Jiri Olsa <jolsa@redhat.com> wrote:
> >> > On Thu, Sep 26, 2013 at 01:36:37PM +0200, Jean Pihet wrote:
> >> >> The newly added dwarf unwinding feature [1] requires:
> >> >> . a recent version (>= 1.1) of libunwind,
> >> >> . libunwind to be configured with --enable-debug-frame.

> >> >> [1] http://www.spinics.net/lists/kernel/msg1598951.html

> >> >> Add the corresponding API tests in the feature check list.

> >> > Acked-by: Jiri Olsa <jolsa@redhat.com>

> >> Thanks for the ack!

> >> Is it possible to get an ack from the perf core maintainers?
> >> Also, is the patch going in Will's tree?

> > This being a tools patch you'd have to ask acme; also I know next to
> > nothing about all this unwind business except that its stupid expensive
> > ;-)
> You are right! It brings some more info on the trace though.

> -- adding Arnaldo in the loop --
> Arnaldo, are you OK with the changes [1]? Jiri acked the patches
> already; Will is willing (no pun intended) to take the ARM specific
> patches [2] in his tree.

As Jiri acked, go ahead and pick as much as you can via Will's tree, I'd
say. :-)

- Arnaldo
 
> [1] http://www.spinics.net/lists/kernel/msg1608921.html and
> http://www.spinics.net/lists/kernel/msg1608922.html
> [2] http://www.spinics.net/lists/kernel/msg1608920.html and
> http://www.spinics.net/lists/kernel/msg1608923.html
> 
> Regards,
> Jean
