From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 11 Apr 2014 20:38:30 -0400 (EDT)
Subject: commit b3a977b224 {ARM: Better virt_to_page() handling} breaks
 Keystone boot
In-Reply-To: <20140412002401.GS16119@n2100.arm.linux.org.uk>
References: <53487A9E.70805@ti.com>
 <alpine.LFD.2.11.1404112011320.980@knanqh.ubzr>
 <20140412002401.GS16119@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1404112036470.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 Apr 2014, Russell King - ARM Linux wrote:

> On Fri, Apr 11, 2014 at 08:13:23PM -0400, Nicolas Pitre wrote:
> > On Fri, 11 Apr 2014, Santosh Shilimkar wrote:
> > 
> > > Russell,
> > > 
> > > The subject commit breaks Keystone boot with higher address space enabled.
> > > I haven't debugged it further but reverting that patch makes it boot again.
> > > 
> > > I will further look at it on Monday, but thought of letting you know.
> > 
> > See my comment at the bottom of this email which might be the cause:
> > 
> > http://article.gmane.org/gmane.linux.ports.arm.kernel/312721
> 
> I still don't see the relevance.  Nothing touches __pv_phys_offset
> after we've booted.  From what I can see, this stuff remains incomplete
> for Keystone.

It certainly looks incomplete, and some out-of-tree might need adjusting 
as mentioned before.


Nicolas
