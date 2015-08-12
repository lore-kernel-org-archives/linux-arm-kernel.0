From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 12 Aug 2015 10:46:59 +0530
Subject: 3.18: lockdep problems in cpufreq
In-Reply-To: <20150811170357.GA24529@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
Message-ID: <20150812051659.GI32049@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-08-15, 18:03, Russell King - ARM Linux wrote:
> On Tue, May 19, 2015 at 12:05:55AM +0200, Rafael J. Wysocki wrote:
> > On Monday, May 18, 2015 07:56:45 PM Russell King - ARM Linux wrote:
> > > On Tue, Dec 16, 2014 at 09:11:53AM +0530, Viresh Kumar wrote:
> > > > On 16 December 2014 at 04:39, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > > > Well, here's a patch which I'm running on top of 3.18 at the moment,
> > > > > which is basically what I described in my email, and I'm running with it
> > > > > and it is without any lockdep complaint.
> > > > 
> > > > We need two separate patches now, one for 3.18 and other one for 3.19-rc.
> > > > 3.19 has see lots of changes in this particular file and so we need to
> > > > change few things here.

Was the patch for latest kernel ever circulated ? Probably that's why
Eduardo never got back to it.

-- 
viresh
