From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 3 Jan 2011 15:17:28 +0100
Subject: zaurus bluetooth regression
In-Reply-To: <AANLkTika7HAEc+BbqSnbo8viUt4nOqoeB69qWZs85-9s@mail.gmail.com>
References: <20110102204532.GA12860@elf.ucw.cz> <20110102203023.GA1545@ucw.cz>
	<AANLkTika7HAEc+BbqSnbo8viUt4nOqoeB69qWZs85-9s@mail.gmail.com>
Message-ID: <20110103141727.GA1536@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> It seems this commit
> >>
> >> commit 7a56aa45982bb87bfca98a2832b5ae782c03364a
> > ...
> >> ...is responsible for my bluetooth problems on zaurus -- at least
> >> bisect pointed to it, ?as I use 16C950-based bluetooth card, it seems
> >> very logical. I'll try 2.6.37-rc8 with that patch reverted...
> >>
> >
> > And yes, 37-rc8 with that reverted results in working bluetooth, so
> > yrs, that patch is responsible.
> 
> could you tell, what kind of problem you're encountering and if you
> could tell, which flag UART_CAP_EFR or UART_CAP_SLEEP causes the
> problem?

Bluetooth will not work with 'tx command timeout', details should be
in bugzilla.

CAP_EFR seems to cause the problem.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
