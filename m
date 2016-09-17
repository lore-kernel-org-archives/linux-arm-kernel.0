From: hzpeterchen@gmail.com (Peter Chen)
Date: Sat, 17 Sep 2016 08:20:55 +0800
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <147398859894.4997.6486248242638696855@sboyd-linaro>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
 <20160914033200.GE30760@b29397-desktop>
 <147383270635.1464.10706917860873291816@sboyd-linaro>
 <20160914080321.GA21674@b29397-desktop>
 <147384270449.13546.495288874027868435@sboyd-linaro>
 <20160915090158.GB6919@b29397-desktop>
 <147398859894.4997.6486248242638696855@sboyd-linaro>
Message-ID: <20160917002055.GA10392@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 06:16:38PM -0700, Stephen Boyd wrote:
> 
> > For #3, it is not the
> > use case for this design. #3 is usually used for the single port which
> > needs to support switching role on the fly without disconnection.
> > So, you may only need to consider #2, you can't use extcon-usb-gpio.c
> > directly since you need to set one gpio to mux the dp/dm, Baolu Lu had
> > USB MUX patch set before which may satisfy your requirement. [1]
> 
> Ok. Did the usb mux patches go anywhere? It seemed to get tangled up in
> DRD framework and I haven't been following along. I'll look into these
> patches more.

DRD framework is denied by Felipe due to only one user can be benefit
from it (chipidea OTG), I don't know the further status of USB MUX,
maybe you can ask for it.

-- 

Best Regards,
Peter Chen
