From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Dec 2010 16:53:11 -0800
Subject: [PATCH v3 0/4] Introduce hardware spinlock framework
In-Reply-To: <AANLkTi=s_Urcin4SAp1mXrKmoyzR2=6YuS3aU+OYYgqK@mail.gmail.com>
References: <1291420247-18171-1-git-send-email-ohad@wizery.com>
	<AANLkTin1fd=Kei7Fo6G+uR+270HdTkc71fvsA6qjBjcA@mail.gmail.com>
	<20101214170656.GA3832@kroah.com>
	<AANLkTi=q=QMQ_Abxb8eUWT_qGG8K=pc892ZB-mqgt_mh@mail.gmail.com>
	<20101216210837.GA22895@kroah.com>
	<AANLkTi=s_Urcin4SAp1mXrKmoyzR2=6YuS3aU+OYYgqK@mail.gmail.com>
Message-ID: <20101218005311.GE5941@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ohad Ben-Cohen <ohad@wizery.com> [101216 13:34]:
> On Thu, Dec 16, 2010 at 11:08 PM, Greg KH <greg@kroah.com> wrote:
> >> > I've seen a lot of discussion about this, are all of the review comments
> >> > now addressed?
> >>
> >> Yes, all comments were addressed in this v3 iteration, and this thread
> >> has been idle for about 10 days.
> >
> > That's because we are all busy with other things :(
> 
> Oh sure, my intention was only positive (to demonstrate that there are
> no outstanding comments), sorry if it sounded differently than
> intended.
> 
> > Sorry, I really don't have the time at the moment to review this code,
> > nor does it seem to affect areas that I maintain, so I don't understand
> > what you are looking for from me.
> 
> Sorry for the noise - I contacted you because you maintain the driver
> core, in the hope you could suggest where this can go through.
> 
> Tony, Andrew, can you please have a look ?
> 
> Any comment or suggestion is appreciated.

Looks sane to me from omap point of view and it seems the locks
are now all timeout based:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony
