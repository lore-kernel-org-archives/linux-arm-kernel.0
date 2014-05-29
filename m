From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 May 2014 10:42:06 +0200
Subject: [PATCH v6 4/4] add 2nd stage page fault handling during live
 migration
In-Reply-To: <53862DF8.80709@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-5-git-send-email-m.smarduch@samsung.com>
 <20140527201945.GD16428@lvm> <53853C2F.8080003@samsung.com>
 <20140528080957.GH16428@lvm> <5386232A.3050602@samsung.com>
 <53862DF8.80709@samsung.com>
Message-ID: <20140529084206.GA61607@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 11:42:00AM -0700, Mario Smarduch wrote:
> 
> >emslot dirty_bitmap during and after write protect.
> > 
> >>
> >> -Christoffer
> 
> Regarding huge pud that's causing some design problems, should huge PUD
> pages be considered at all?
> 
I'm not sure if there is any support for this on aarch64 or anyone
planning to work on this.

Steve?

-Christoffer
