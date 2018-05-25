From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 25 May 2018 17:46:28 -0500
Subject: [PATCH] arm64: dts: msm8916: fix Coresight ETF graph connections
In-Reply-To: <CANLsYkz9tAH7mazz2LNCtoYsdH4f5bKfGWEnJHsgH0mK6vNMEg@mail.gmail.com>
References: <20180508150952.24562-1-robh@kernel.org>
 <20180508150952.24562-3-robh@kernel.org>
 <CAL_JsqL8qBiJUMyUEcih07UoFSAghn6Amfo8OfY-pKU-QX2_mw@mail.gmail.com>
 <20180524044853.713.23166@silver>
 <CANLsYkz9tAH7mazz2LNCtoYsdH4f5bKfGWEnJHsgH0mK6vNMEg@mail.gmail.com>
Message-ID: <20180525224628.GB25153@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 10:32:46AM -0600, Mathieu Poirier wrote:

<snip>

> >
> >  Hi Rob,
> >
> >  I no longer have access to this hardware and documentation.
> >  I am sure that Mathieu and friends will take care for verification
> >  of this patch :-)
> 
> The code triggers on the "slave-mode" property rather than the labels,
> so this patch has no effect on how a path is established.  I've tested
> this on a 410c and things look good.
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks for verifying this Matthew.  I'll put this in for a fixes as I just sent
out my last set for 4.18.

Regards,

Andy
