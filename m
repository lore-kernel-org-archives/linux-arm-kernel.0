From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 23 Jun 2016 11:16:36 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Drop legacy board file for n900
In-Reply-To: <576ADA8B.10404@gmail.com>
References: <1465987689-14812-1-git-send-email-tony@atomide.com>
 <20160621112944.GV29844@pali> <20160621113215.GP22406@atomide.com>
 <201606221848.41305@pali> <20160622175959.GA21075@amd>
 <576ADA8B.10404@gmail.com>
Message-ID: <20160623091636.GA25882@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2016-06-22 21:35:55, Ivaylo Dimitrov wrote:
> On 22.06.2016 20:59, Pavel Machek wrote:
> >
> >...and graphics acceleration and power management. But who needs
> >accelerated graphics, and power management will be solved. So yes,
> >N900 is the best phone :-).
> >
> 
> Well, actually we have SGX out-of-tree driver working (with some glitches)
> with 4.7-rc, Maemo 5 needs it :)

Good :-).

I'm currently playing with the camera... and I can't get the 5MPx code
to work. I can only capture the photos after the resizer. Capturing
small picture, resizing it to 5MPx using the resizer, and then reading
that from linux works, but capturing 5MPx picture, resizing it to
whatever size results in 4 copies.

I tried disabling the 5Mpx modes in the et8* driver, hoping one of
them works, but it does not.

Does 5Mpx capture work for you?

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
