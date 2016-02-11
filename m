From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Feb 2016 07:02:41 -0800
Subject: [PATCH 1/7] mmc: omap_hsmmc: Fix PM regression with deferred
 probe for pm_runtime_reinit
In-Reply-To: <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-2-git-send-email-tony@atomide.com>
 <CAPDyKFpAcsfLgtu93P45fTEg11MjdGwREcyeGSS7vt6GWbNu_w@mail.gmail.com>
Message-ID: <20160211150240.GR19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160211 02:19]:
> On 11 February 2016 at 00:02, Tony Lindgren <tony@atomide.com> wrote:
> >
> > Ulf, I'd like to merge this along with other related fixes via the
> > ARM SoC tree if no objections, please review and ack if this look OK
> > to you.
> 
> I have some other omap_hsmmc patches queued for 4.6, so I prefer to
> send this via my mmc tree.
> 
> I guess that's okay as well!?

Naturally yes, please go ahead thanks!

Regards,

Tony
