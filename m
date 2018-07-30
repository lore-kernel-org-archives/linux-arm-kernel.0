From: greg@kroah.com (Greg KH)
Date: Mon, 30 Jul 2018 11:14:11 +0200
Subject: [PATCH] staging/vc04_services: Use __user annotation for
 user-space pointers
In-Reply-To: <CAGR7KeoDrp8FBX_H1a8h9hVFF_w9mLXGkvCT6jJAacG7-morRg@mail.gmail.com>
References: <20180724083217.20921-1-cmaiolino28@gmail.com>
 <20180730085811.GA30820@kroah.com>
 <CAGR7KeoDrp8FBX_H1a8h9hVFF_w9mLXGkvCT6jJAacG7-morRg@mail.gmail.com>
Message-ID: <20180730091411.GA31261@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 11:08:06AM +0200, Carlos Maiolino wrote:
> On Mon, Jul 30, 2018 at 10:58 AM, Greg KH <greg@kroah.com> wrote:
> > On Tue, Jul 24, 2018 at 10:32:17AM +0200, Carlos Maiolino wrote:
> >> Fix several sparse warnings regarding different address space
> >> assignments, like example below, by properly annotating pointers
> >> expected to carry user space addresses.
> >>
> >> warning: incorrect type in argument 1 (different address spaces)
> >> Signed-off-by: Carlos Maiolino <cmaiolino28@gmail.com>
> >> ---
> >
> > We need a blank line befor your signed-off-by line please.
> >
> 
> Thanks, I'll resend, or do you prefer me to way until this get a review from
> the maintainer, and I resend the fixed description with the reviewed-by?

I should never have to hand-edit a patch, otherwise maintainers will not
scale, so yes, I need a new version.  But it would be great if we got a
review from the proper maintainers first so you know if anything else
needs to be done.

thanks,

greg k-h
