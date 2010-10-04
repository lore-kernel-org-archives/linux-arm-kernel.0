From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 04 Oct 2010 08:46:46 +0200
Subject: [PATCH v3 4/5] mfd: regulator: max8998: voltages and GPIOs defined
	at platform data structure
In-Reply-To: <1286026413.3125.27.camel@odin>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
	<1285590747-32404-5-git-send-email-l.majewski@samsung.com>
	<20100927184336.GK2560@sortiz-mobl> <1286026413.3125.27.camel@odin>
Message-ID: <20101004084646.4de3714d@lmajewski.digital.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 02 Oct 2010 14:33:33 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Mon, 2010-09-27 at 20:43 +0200, Samuel Ortiz wrote:
> > Hi Lukasz,
> > 
> > On Mon, Sep 27, 2010 at 02:32:26PM +0200, Lukasz Majewski wrote:
> > > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Fine with me:
> > Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> > 
> 
> Lukasz, this is not applying against the regulator next tree.
> Can you redo and add Mark and Samuels Acks.
> 
> Thanks
> 
> Liam

Hi Liam,

I've fetched the newest voltage-2.6/for-next and merge it with newest
mfd-2.6/for next. After that all patches are applying and kernel is
building without errors.

The problem with this patch series is that it "touches" two
repositories: voltage-2.6 and mfd-2.6. 

I'm a bit confused how such situation should be resolved, since it
involves two separate repositories (and two maintainers to cooperate).

-- 
Best regards,

Lukasz Majewski

Samsung Poland R0d5c1f412cf166c0cd87b0f6eb7fed70a2&D Center
Platform Group
