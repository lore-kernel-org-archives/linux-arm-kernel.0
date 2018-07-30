From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 30 Jul 2018 09:26:13 -0700
Subject: [PATCH] clk: scmi: Fix the rounding of clock rate
In-Reply-To: <20180730114056.GA17362@e107155-lin>
References: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
 <153270946725.48062.11195853363758024681@swboyd.mtv.corp.google.com>
 <CADGdYn5T2-B2UE9DX3wFHdvqfF85n0NAbKDBf2KHOQreRi=H+g@mail.gmail.com>
 <20180730114056.GA17362@e107155-lin>
Message-ID: <153296797329.17365.14490424418553594815@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sudeep Holla (2018-07-30 04:40:56)
> On Mon, Jul 30, 2018 at 11:03:51AM +0530, Amit Daniel Kachhap wrote:
> > Hi,
> > 
> > On Fri, Jul 27, 2018 at 10:07 PM, Stephen Boyd <sboyd@kernel.org> wrote:
> > > Quoting Amit Daniel Kachhap (2018-07-27 07:01:52)
> > >> This fix rounds the clock rate properly by using quotient and not
> > >> remainder in the calculation. This issue was found while testing HDMI
> > >> in the Juno platform.
> > >>
> > >> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> > >
> > > Any Fixes: tag here?
> > Yes, This patch is tested with Linux v4.18-rc6 tag.
> >
> 
> No Stephen meant the commit that this fixes, something like below:
> 
> Fixes: 6d6a1d82eaef ("clk: add support for clocks provided by SCMI")
> 
> so that it can get backported if required.
> 

Yep! Thanks!
