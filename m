From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 24 Jun 2013 13:45:15 +0200
Subject: [GIT PULL] ARM: CPUFreq updates for 3.11
In-Reply-To: <CAKohpomdnEgDcAExoyN1b4vohHNEg3NDH1mM8NWG8gQoPvff+Q@mail.gmail.com>
References: <CAKohpo=v4qPDH32Y4ithr_p007nTn5AOUzkUCiHTGgQN6-=BEw@mail.gmail.com>
 <7195611.gCcafMWC85@vostro.rjw.lan>
 <CAKohpomdnEgDcAExoyN1b4vohHNEg3NDH1mM8NWG8gQoPvff+Q@mail.gmail.com>
Message-ID: <1662523.HdXbLYrd2q@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 24, 2013 04:40:27 PM Viresh Kumar wrote:
> On 24 June 2013 16:29, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > In your original series that patch was the last one.  What made you change your
> > mind and put it in front?
> 
> I initially thought that this one would break git bisect (code would
> compile, but would fail) for platforms whose code I have fixed in
> this patchset.
> 
> But that is true only for failure cases, otherwise code would work as
> normal.
> 
> And hence kept this at the top this time.

Well, it should go last.  Also I'd prefer to apply it directly.

Please check my comment in there too.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
