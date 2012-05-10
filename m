From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 May 2012 15:10:13 -0700
Subject: [PATCH] ARM: OMAP2+: irq: Increase no of supported interrupts
 to 128
In-Reply-To: <87d36bvh9a.fsf@ti.com>
References: <1336486679-15892-1-git-send-email-hvaibhav@ti.com>
 <87lil2o6u1.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA1C06F@DBDE01.ent.ti.com>
 <87d36bvh9a.fsf@ti.com>
Message-ID: <20120510221012.GP21851@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120510 14:53]:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> >
> > Let me finish up with am33xx baseport upstream activity which is currently 
> > going on at full swing, then next thing I will pick up is this code cleanup.
> >
> > I still feel, this is still a valid cleanup patch, and can be merged, as it 
> > is required/used when we do major cleanup.
> 
> Well, Tony can make that decision.
> 
> Personally, I think this patch continues to add confusion on top of an
> existing mess, and to me provides the proverbial straw that broke the
> camel's back.
> 
> That being said, the INTC core is an obviously important and sensitive
> piece of code so needs to be handled with care.
> 
> In case Tony decides to merge this patch and allow a future** cleanup,
> I'll provide some comments.

Heh I agree with Kevin here :)

Tony

 
> ** since they rarely happen, we tend to not have too much faith in
>    promises of mythical "future" cleanups.  This is not because we don't
>    trust you personally, but simply based on based experience.
