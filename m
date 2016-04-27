From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Apr 2016 07:17:53 -0700
Subject: [PATCH 2/2] mmc: omap_hsmmc: Check if MMC slot name is passed in
 pdata
In-Reply-To: <CAPDyKFqCMfBx=VFy05MNDhO5ZpLw9x=Xmdst9JR0zHy+GHYJyQ@mail.gmail.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-3-git-send-email-tony@atomide.com>
 <CAPDyKFqCMfBx=VFy05MNDhO5ZpLw9x=Xmdst9JR0zHy+GHYJyQ@mail.gmail.com>
Message-ID: <20160427141753.GX5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160427 01:53]:
> On 27 April 2016 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> > The legacy user space for n900 relies on the MMC slot names.
> > Let's check if those are passed in pdata and use them.
> >
> > Then when we have a generic MMC slot name binding we can
> > switch to use that assuming it works for the n900 legacy
> > user space too.
> 
> I dropped this section, because I don't think it will happen.

Yeah fine with me.

> Thanks, applied for next!

Thanks!

Tony
