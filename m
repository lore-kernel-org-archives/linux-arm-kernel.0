From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 25 Oct 2014 20:29:00 +0800
Subject: [PATCH 1/2] ARM: dts: imx53: Improve SSI clocks description
In-Reply-To: <CAOMZO5DYrH5-+QmNuppSEmmrqntusOM4ziXzTvRKtD4tqy0E7A@mail.gmail.com>
References: <1411082629-25860-1-git-send-email-festevam@gmail.com>
 <20140925075433.GE6405@dragon>
 <CAOMZO5DYrH5-+QmNuppSEmmrqntusOM4ziXzTvRKtD4tqy0E7A@mail.gmail.com>
Message-ID: <20141025122858.GE3648@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 10:10:15AM -0200, Fabio Estevam wrote:
> Shawn,
> 
> On Thu, Sep 25, 2014 at 4:54 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Thu, Sep 18, 2014 at 08:23:48PM -0300, Fabio Estevam wrote:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> SSI block has 'ipg' clock for internal peripheral access and also 'baud' clock
> >> for generating bit clock when SSI operates in master mode.
> >>
> >> Add the extra 'baud' clock so that we can have SSI functional in master mode.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >
> > Applied both, thanks.
> 
> I am not able to see these patches in linux-next yet.

Yes, I haven't updated my for-next branch.  Will do soon.

Shawn
