From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Apr 2016 07:17:03 -0700
Subject: [PATCH 1/2] ARM: OMAP2+: n900 needs MMC slot names for legacy
 user space
In-Reply-To: <CAPDyKFokkpF_-yxE+G2_nvC2q3uHkMCxZJHYU7y4KRRDWfvPTQ@mail.gmail.com>
References: <1461714383-9956-1-git-send-email-tony@atomide.com>
 <1461714383-9956-2-git-send-email-tony@atomide.com>
 <CAPDyKFokkpF_-yxE+G2_nvC2q3uHkMCxZJHYU7y4KRRDWfvPTQ@mail.gmail.com>
Message-ID: <20160427141703.GW5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160427 01:50]:
> On 27 April 2016 at 01:46, Tony Lindgren <tony@atomide.com> wrote:
> > Let's pass the slot names in pdata like the legacy code does.
> > Once we have a generic DT binding for the slot names we can
> > switch to that.
> 
> I am not sure we ever will get a DT binding accepted for the slot
> name. It seem far from being a HW description. :-)

Hmm it does describe where on the the device the MMC is
located though as in "external" or "internal".

> Instead, the long term and proper solution, is to enable userspace to
> be able to use UUID/PARTID instead.

OK.

> Until that happens, I guess this will have to do.

Yeah especially as that has been working with the legacy booting
for years.

Regards,

Tony
