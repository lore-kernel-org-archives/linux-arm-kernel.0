From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 2 Mar 2015 11:35:04 -0800
Subject: [rtc-linux] [PATCH 2/2] rtc: mediatek: Add MT63xx RTC driver
In-Reply-To: <1425284436.8684.11.camel@mtksdaap41>
References: <1422437276-41334-1-git-send-email-eddie.huang@mediatek.com>
 <1422437276-41334-3-git-send-email-eddie.huang@mediatek.com>
 <20150223135044.108ea32a65063a50aa36a309@linux-foundation.org>
 <1425284436.8684.11.camel@mtksdaap41>
Message-ID: <20150302113504.59dff34c8261c9c002aebf5f@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Mar 2015 16:20:36 +0800 Eddie Huang <eddie.huang@mediatek.com> wrote:

> > WARNING: DT compatible string "mediatek,mt6397-rtc" appears un-documented -- check ./Documentation/devicetree/bindings/
> > #488: FILE: drivers/rtc/rtc-mt6397.c:334:
> > +	{ .compatible = "mediatek,mt6397-rtc", },
> > 
> > 
> Do you include patch "[PATCH 1/2] dt: bindings: Add Mediatek RTC driver
> binding document" in this series ?
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/320425.html
> 
> I think this warning shouldn't happen if include this patch.

I can't find that patch on rtc-linux or linux-kernel.  Resend, please?
