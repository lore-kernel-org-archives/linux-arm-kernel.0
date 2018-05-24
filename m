From: iivanov.xz@gmail.com (Ivan T. Ivanov)
Date: Thu, 24 May 2018 07:48:53 +0300
Subject: [PATCH] arm64: dts: msm8916: fix Coresight ETF graph connections
In-Reply-To: <CAL_JsqL8qBiJUMyUEcih07UoFSAghn6Amfo8OfY-pKU-QX2_mw@mail.gmail.com>
References: <20180508150952.24562-1-robh@kernel.org>
 <20180508150952.24562-3-robh@kernel.org>
 <CAL_JsqL8qBiJUMyUEcih07UoFSAghn6Amfo8OfY-pKU-QX2_mw@mail.gmail.com>
Message-ID: <20180524044853.713.23166@silver>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2018-05-23 23:29:29)
> On Tue, May 8, 2018 at 10:09 AM, Rob Herring <robh@kernel.org> wrote:
> > The ETF input should be connected to the funnel output, and the ETF
> > output should be connected to the replicator input. The labels are wrong
> > and these got swapped:
> >
> > Warning (graph_endpoint): /soc/funnel at 821000/ports/port at 8/endpoint: graph connection to node '/soc/etf at 825000/ports/port at 1/endpoint' is not bidirectional
> > Warning (graph_endpoint): /soc/replicator at 824000/ports/port at 2/endpoint: graph connection to node '/soc/etf at 825000/ports/port at 0/endpoint' is not bidirectional
> >
> > Fixes: 7c10da373698 ("arm64: dts: qcom: Add msm8916 CoreSight components")
> > Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Andy Gross <andy.gross@linaro.org>
> > Cc: David Brown <david.brown@linaro.org>
> > Cc: linux-arm-msm at vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Ping. Still seeing warnings in -next for these.
>

 Hi Rob,

 I no longer have access to this hardware and documentation.
 I am sure that Mathieu and friends will take care for verification
 of this patch :-)

 Regards,
 Ivan
