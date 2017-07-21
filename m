From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 21 Jul 2017 13:19:16 -0300
Subject: [PATCH v1] perf: cs-etm: Fix ETMv4 CONFIGR entry in perf.data file
In-Reply-To: <CANLsYkxDLVONpuQpF6Zo-gUPf+WVt2v+DLNduq0mDMk0XAZ5hw@mail.gmail.com>
References: <1499878883-3066-1-git-send-email-mike.leach@linaro.org>
 <CANLsYkxDLVONpuQpF6Zo-gUPf+WVt2v+DLNduq0mDMk0XAZ5hw@mail.gmail.com>
Message-ID: <20170721161916.GH4134@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Jul 21, 2017 at 08:50:09AM -0600, Mathieu Poirier escreveu:
> On 12 July 2017 at 11:01, Mike Leach <mike.leach@linaro.org> wrote:
> > The value passed into the perf.data file for the CONFIGR register in ETMv4
> > was incorrectly being set to the command line options/ETMv3 value.
> >
> >                 info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
> >                                                 coresight_get_trace_id(cpu);
> 
> I have tested this patch on my side and things work as advertised now.
> 
> Arnaldo, if you want to pick this up through your tree then:
> 
> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Otherwise I'll get this, whatever you prefer.

I'll get it, thanks for the ping,

- Arnaldo
