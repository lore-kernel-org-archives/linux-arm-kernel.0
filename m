From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Feb 2016 09:54:26 -0800
Subject: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <CAPDyKFpwGcCW_Vwz07cgh8LxGmxu9=GVch0MVJEpNJ19zoLZ7g@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-2-git-send-email-tony@atomide.com>
 <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
 <20160211150240.GR19432@atomide.com>
 <CAPDyKFo4Jyjwyvr3P5VHfDhQ87K9mnR01N-NtKz-yx2ycnfOLg@mail.gmail.com>
 <20160211172632.GT19432@atomide.com>
 <CAPDyKFpwGcCW_Vwz07cgh8LxGmxu9=GVch0MVJEpNJ19zoLZ7g@mail.gmail.com>
Message-ID: <20160222175426.GI13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160212 05:00]:
> On 11 February 2016 at 18:26, Tony Lindgren <tony@atomide.com> wrote:
> > Subject: [PATCH] mmc: omap_hsmmc: Fix PM regression with deferred probe for
> >  pm_runtime_reinit
>
> Thanks, applied for fixes!

Ulf, any news on getting this into the mainline tree?

My PM tests have been now broken for six weeks or something
because of this!

Regards,

Tony
