From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Tue, 26 Jan 2016 11:33:33 -0300
Subject: [PATCH V8 21/23] perf tools: adding perf_evlist to
 *info_priv_size()
In-Reply-To: <56A78268.7020102@intel.com>
References: <1452807977-8069-1-git-send-email-mathieu.poirier@linaro.org>
 <1452807977-8069-22-git-send-email-mathieu.poirier@linaro.org>
 <CANLsYkyc85famRPpfZk+O3iHXdbULV8-a=izUq=GbgMeiGw=Og@mail.gmail.com>
 <20160125210858.GC22501@kernel.org> <56A78268.7020102@intel.com>
Message-ID: <20160126143333.GE4361@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Tue, Jan 26, 2016 at 04:27:52PM +0200, Adrian Hunter escreveu:
> On 25/01/16 23:08, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jan 25, 2016 at 01:48:28PM -0700, Mathieu Poirier escreveu:
> >> On 14 January 2016 at 14:46, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> >>> On some architecture the size of the private header may
> >> Arnaldo,
> >>
> >> As with my previous email, I can't queue this patch for 4.6 without at
> >> least a reviewed by from you.
> >>
> >> It has been rebased to 4.5-rc1 here [1] for your convenience.  I will
> >> be happy to use another baseline should that be more adequate for you.
> > 
> > Adrian, are you ok with this?
> 
> I will try to look at this and the others in the next day or two.
> 

Thanks, that will help,

- Arnaldo
