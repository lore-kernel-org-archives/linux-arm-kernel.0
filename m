From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Oct 2012 22:27:55 +0000
Subject: [PULL REQ] IXP4xx changes for Linux 3.7
In-Reply-To: <20121029082940.GC2527@netboy.at.omicron.at>
References: <m3bog6m5iz.fsf@intrepid.localdomain>
 <m3a9vkahci.fsf@intrepid.localdomain>
 <20121029082940.GC2527@netboy.at.omicron.at>
Message-ID: <201210302227.55857.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 October 2012, Richard Cochran wrote:
> On Thu, Oct 18, 2012 at 12:01:17AM +0200, Krzysztof Halasa wrote:
> > 
> > Don't get me wrong. If I had time for this it could be different.
> > Unfortunately IXP4xx is a legacy arch, and for me it's simply a hobby at
> > this point. Given the raised barriers to participate, probably aimed at
> > paid maintainers, I have to quit doing this.
> > 
> > BTW since Imre has probably even much less time, it would be a good time
> > to find someone to maintain IXP4xx code. I will be publishing (from time
> > to time) my tree (I'm using the hw myself), so even simple
> > cherry-picking would probably make some sense.
> 
> So if no one else wants to do this, then I am willing to look after
> the IXP code. I think that I do have the time for it.

Thanks for the offer! 

Jason Cooper was also volunteering to help out with this, and even we can't
convince Krzysztof to continue doing it, there is also Imre who is officially
listed as maintainer for IXP4xx and who has not commented on this. As Krzysztof
mentions, he probably doesn't have much time for it, but I'd like to give
him the chance to comment as well.

I'm sure we can find some solution between the four of you. Right now, I think
we should focus on getting the bug fixes from Krzysztof's tree into mainline
and the stable kernels where applicable, and then establish a better working
mode for the future kernels.

	Arnd
