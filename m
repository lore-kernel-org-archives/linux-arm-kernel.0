From: greg@kroah.com (Greg KH)
Date: Tue, 5 Dec 2017 18:28:11 +0100
Subject: [v2] mfd: stm32: Adopt SPDX identifier
In-Reply-To: <20171205172337.GA24480@roeck-us.net>
References: <20171205152418.28104-1-benjamin.gaignard@st.com>
 <20171205172337.GA24480@roeck-us.net>
Message-ID: <20171205172811.GA5534@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 05, 2017 at 09:23:37AM -0800, Guenter Roeck wrote:
> On Tue, Dec 05, 2017 at 04:24:18PM +0100, benjamin.gaignard at linaro.org wrote:
> > Add SPDX identifier
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > ---
> >  drivers/mfd/stm32-lptimer.c       | 6 +-----
> >  drivers/mfd/stm32-timers.c        | 4 +---
> >  include/linux/mfd/stm32-lptimer.h | 6 +-----
> >  include/linux/mfd/stm32-timers.h  | 4 +---
> >  4 files changed, 4 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/mfd/stm32-lptimer.c b/drivers/mfd/stm32-lptimer.c
> > index 075330a25f61..a00f99f36559 100644
> > --- a/drivers/mfd/stm32-lptimer.c
> > +++ b/drivers/mfd/stm32-lptimer.c
> > @@ -1,13 +1,9 @@
> > +// SPDX-License-Identifier: GPL-2.0
> >  /*
> 
> I have been wondering - why is the SPDX identifier for the most part added
> as separate C++ comment at the beginning of the file, and not inline with
> the rest of the top comments ?  SPDX doesn't mandate this - the examples
> I can find on the SPDX web site all show it inline. Is there a special
> Linux kernel convention ?

See the patch series from Thomas that answers this question for you by
adding documentation to the kernel explaining it all :)

thanks,

greg k-h
