From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Oct 2013 15:31:32 +0100
Subject: [PATCH 3/4] perf tools: Check libunwind for availability of
 dwarf parsing feature
In-Reply-To: <20131008142830.GI4018@ghostprotocols.net>
References: <1380195398-4402-1-git-send-email-jean.pihet@linaro.org>
 <1380195398-4402-4-git-send-email-jean.pihet@linaro.org>
 <20130926124829.GA3284@krava.brq.redhat.com>
 <CAFrcx1nDe6mhxEuU4ROJGOmGFaYtVnnhXYirkmhRb1NEecNhtw@mail.gmail.com>
 <20131008104740.GU3081@twins.programming.kicks-ass.net>
 <CAFrcx1kNONpBcsEHX1PN0kNUCOAkBCid+bgbv3mc0TPu=F+MYg@mail.gmail.com>
 <20131008142830.GI4018@ghostprotocols.net>
Message-ID: <20131008143131.GA21189@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 03:28:30PM +0100, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 08, 2013 at 04:15:40PM +0200, Jean Pihet escreveu:
> > >> On 26 September 2013 14:48, Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > >> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> > -- adding Arnaldo in the loop --
> > Arnaldo, are you OK with the changes [1]? Jiri acked the patches
> > already; Will is willing (no pun intended) to take the ARM specific
> > patches [2] in his tree.
> 
> As Jiri acked, go ahead and pick as much as you can via Will's tree, I'd
> say. :-)

Cheers guys, that suits me!

Will
