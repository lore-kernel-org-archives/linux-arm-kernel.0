From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 8 Oct 2013 12:47:40 +0200
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of
 dwarf parsing feature
In-Reply-To: <CAFrcx1nDe6mhxEuU4ROJGOmGFaYtVnnhXYirkmhRb1NEecNhtw@mail.gmail.com>
References: <1380195398-4402-1-git-send-email-jean.pihet@linaro.org>
 <1380195398-4402-4-git-send-email-jean.pihet@linaro.org>
 <20130926124829.GA3284@krava.brq.redhat.com>
 <CAFrcx1nDe6mhxEuU4ROJGOmGFaYtVnnhXYirkmhRb1NEecNhtw@mail.gmail.com>
Message-ID: <20131008104740.GU3081@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 12:44:32PM +0200, Jean Pihet wrote:
> Hi,
> 
> On 26 September 2013 14:48, Jiri Olsa <jolsa@redhat.com> wrote:
> > On Thu, Sep 26, 2013 at 01:36:37PM +0200, Jean Pihet wrote:
> >> The newly added dwarf unwinding feature [1] requires:
> >> . a recent version (>= 1.1) of libunwind,
> >> . libunwind to be configured with --enable-debug-frame.
> >>
> >> [1] http://www.spinics.net/lists/kernel/msg1598951.html
> >>
> >> Add the corresponding API tests in the feature check list.
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > thanks,
> > jirka
> 
> Thanks for the ack!
> 
> Is it possible to get an ack from the perf core maintainers?
> Also, is the patch going in Will's tree?

This being a tools patch you'd have to ask acme; also I know next to
nothing about all this unwind business except that its stupid expensive
;-)
