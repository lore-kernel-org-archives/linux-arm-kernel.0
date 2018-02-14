From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Feb 2018 09:24:56 -0800
Subject: [PATCH v2 08/16] mmc: sdhci-omap: Add support to override f_max
 and iodelay from pdata
In-Reply-To: <CAPDyKFrhpry40TCjmQ_-WO-EWa2BCL0eNXLZB_UobGaYbsBiHA@mail.gmail.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-9-kishon@ti.com>
 <CAPDyKFrhpry40TCjmQ_-WO-EWa2BCL0eNXLZB_UobGaYbsBiHA@mail.gmail.com>
Message-ID: <20180214172455.GO6364@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [180214 09:53]:
> On 5 February 2018 at 13:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
> > versions of EVM can come with either revision 1.1 or revision 1.0 of
> > silicon.
> >
> > The device-tree file is written to support rev 2.0 of silicon.
> > pdata-quirks are used to then override the settings needed for
> > PG 1.1 silicon.
> >
> > PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
> > can operate as well as different IOdelay numbers.
> 
> I fail to understand the need for platform data. Why can't DT be used
> for the older revisions as well?

Maybe the silicon revision is not available via soc_device_match()?

Regards,

Tony
