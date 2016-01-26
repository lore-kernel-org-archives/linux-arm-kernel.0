From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 26 Jan 2016 15:51:16 -0300
Subject: [PATCH V8 20/23] perf tools: making function set_max_cpu_num()
 non static
In-Reply-To: <CANLsYkwbBCwT0B4NV0pGo+avyyX9kiPzYZK5WtmfHaqnW8Q6uA@mail.gmail.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-21-git-send-email-mathieu.poirier@linaro.org>
 <CANLsYkzmTMi3jmVjwNiNsw6P5pPkZEz6zYWFsVzayy+r2ojTTA@mail.gmail.com>
 <20160125211242.GF22501@kernel.org>
 <20160125212955.GG22501@kernel.org>
 <CANLsYkwbBCwT0B4NV0pGo+avyyX9kiPzYZK5WtmfHaqnW8Q6uA@mail.gmail.com>
Message-ID: <20160126185116.GA11676@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Jan 26, 2016 at 10:08:21AM -0700, Mathieu Poirier escreveu:
> On 25 January 2016 at 14:29, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Mon, Jan 25, 2016 at 06:12:42PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Mon, Jan 25, 2016 at 01:46:22PM -0700, Mathieu Poirier escreveu:
> >> > On 14 January 2016 at 14:46, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >> > I can't queue this patch for 4.6 without at least a reviewed by from you.
> >>
> >> This one I remember, looks ugly, the name set_max_cpu_num() looks
> >> strange, when that was restricted (static) to that cpumap.c file, it
> >> wasn't a problem, exporting it for wider usage looks bad.
> >>
> >> You've been waiting for this for quite a while, it seems, lemme stop
> >> what I am doing to check this...
> >
> > So, please check the patch below, what you need then is just to use
> > cpu__max_cpu().
> 
> I like your approach - thanks for the review.  I will spin V9 when I
> have received Adrian's comments.

I'll take that as an Acked-by: and since this improves the current
situation by hiding needlessly exported global variables, I'll get it in
now, thanks.

- Arnaldo
