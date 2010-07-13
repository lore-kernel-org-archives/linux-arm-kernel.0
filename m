From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 13 Jul 2010 20:27:47 +0400
Subject: [PATCH v2 0/3] s3c24xx: iPAQ rx1950 series
In-Reply-To: <201007131845.10426.anarsoul@gmail.com>
References: <1278781069-30521-1-git-send-email-anarsoul@gmail.com>
	<20100713151310.GA12234@oksana.dev.rtsoft.ru>
	<201007131845.10426.anarsoul@gmail.com>
Message-ID: <20100713162747.GA21613@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 06:45:04PM +0300, Vasily Khoruzhick wrote:
> ? ????????? ?? 13 ???? 2010 18:13:10 ????? Anton Vorontsov ???????:
> 
> > No, please. Factor out LED triggers addition into a separate patch
> > and we will discuss* it. That way it won't block this driver merge.
> 
> I'm not in hurry :)

But you should. Months later you'll not have time/energy to
continue, and if you not merge your patches ASAP, then all
the great work that you did will quickly become outdated
(like most of handhelds.org projects nowadays. ;-)

> But I want it to be merged with all functionality 
> (getting status/charging/LEDs).

Sure thing, in the end it will have all the functionality.

But let's do one thing at a time? Just factor out the LEDs
stuff into a separate patch, and we'll think how to deal with
these LEDs.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
