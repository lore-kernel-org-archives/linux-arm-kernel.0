From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Mon, 12 Aug 2013 19:36:13 +0900
Subject: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
In-Reply-To: <1376060060.11201.5.camel@linux-builds1>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
 <520459C9.8020305@samsung.com>
 <001301ce94fd$09c78330$1d568990$%jun@samsung.com>
 <1376060060.11201.5.camel@linux-builds1>
Message-ID: <000301ce9747$c47e3240$4d7a96c0$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, August 09, 2013, Dinh Nguyen wrote:
> Hi Seungwon Jeon,
> 
> On Fri, 2013-08-09 at 21:36 +0900, Seungwon Jeon wrote:
> > On Fri, August 09, 2013, Jaehoon Chung wrote:
> > > Hi Dinh
> > >
> > > On 08/09/2013 07:55 AM, dinguyen at altera.com wrote:
> > > > From: Dinh Nguyen <dinguyen@altera.com>
> > > >
> > > > Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
> > > > and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
> > > > just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.
> > > >
> > Though host controller based on Synopsys is required to implement clock phase shift,
> > actual implementation could be different. I'm not sure that this above parameters are common just
> now.
> > But if some more host controllers are introduced, we may define clearly.
> 
> But the bindings can be common between socfpga and exynos right? The
> values in the bindings represent the same thing, just the implementation
> for the clock phase shift can be different.

Hmm. I also feel like similar though I didn't see the socfpga.
As I take a glance, div of socfpga currently seems fixed in host side.
Do you need it from dts?

How about rockchip's mshc platform?
I guess we could wait and see more.

Thanks,
Seungwon Jeon
