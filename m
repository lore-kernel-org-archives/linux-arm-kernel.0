From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 12 Oct 2018 21:38:37 +0530
Subject: [PATCH 0/4] Add clock support for Hi3670 SoC
In-Reply-To: <153936020982.5275.4942701350789062401@swboyd.mtv.corp.google.com>
References: <20180921060103.21370-1-manivannan.sadhasivam@linaro.org>
 <20181012033857.GA5438@Mani-XPS-13-9360>
 <153936020982.5275.4942701350789062401@swboyd.mtv.corp.google.com>
Message-ID: <20181012160837.GA11560@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 09:03:29AM -0700, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2018-10-11 20:38:58)
> > On Thu, Sep 20, 2018 at 11:00:59PM -0700, Manivannan Sadhasivam wrote:
> > > This patchset adds clock support for Hi3670 SoC from HiSilicon utilizing
> > > the HiSi common clock code. While adding clock support, let's remove the
> > > fixed clock for UART and source SoC clock on HiKey970 board.
> > > 
> > > This patchset has been verified on HiKey970 board.
> > >
> > 
> > Hi,
> > 
> > Any update on this series?
> > 
> 
> Can I merge the clk driver part by itself? Are you looking for an ack
> from clk maintainers?
> 

Yes, please. I'm not sure about the maintainer for this clk part and it
is best if you can take a look and merge if its ok.

Thanks,
Mani
