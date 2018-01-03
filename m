From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Jan 2018 15:06:54 -0200
Subject: [PATCH v2] ARM: dts: imx6: RDU2: disable internal watchdog
In-Reply-To: <CAHQ1cqGE8GzHiHq0NRPoAKmrqv6ZDcFO+0=hnAEtog8jcnapyQ@mail.gmail.com>
References: <20180101212451.11516-1-andrew.smirnov@gmail.com>
 <CAOMZO5AZU0LOcz6s2w-mThJfJeO0_mXga_1Cc2-aBkMOXk_-dA@mail.gmail.com>
 <CAHQ1cqGE8GzHiHq0NRPoAKmrqv6ZDcFO+0=hnAEtog8jcnapyQ@mail.gmail.com>
Message-ID: <CAOMZO5BAH4Dv7VFucBe080XQWoQ8pfmo1=4-sCa9L8PXJp_TfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 3, 2018 at 3:04 PM, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> It seems that with exception of "audmux" and "iomuxc" the nodes are in
> alphabetical order (and I suspect "audmux" falls under the same
> exception "iomuxc" does?). What did you have in mind for that node?
> Placing it after "audmux"?

Yes, putting 'wdog' after audmux would be better.

Thanks
