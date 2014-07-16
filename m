From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 16 Jul 2014 17:28:11 +0200
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
 <20140716160256.7e8dbccf@free-electrons.com>
 <CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
Message-ID: <20140716172811.2289a64c@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Viresh Kumar,

On Wed, 16 Jul 2014 20:55:21 +0530, Viresh Kumar wrote:
> On 16 July 2014 19:32, Thomas Petazzoni
> <thomas.petazzoni@free-electrons.com> wrote:
> > Could you get your tree in linux-next, or get your patches merged by
> > Rafael in his linux-next branch so that they will appear in linux-next ?
> 
> They aren't in yet and Rafael haven't started pushing stuff for 3.16 yet.

I guess you meant 3.17, right?

> But it might be pushed sometime soon, no deadlines decided yet.

Would be good to have this soon, since the 3.17 merge window is
approaching. You asked me to use this cpufreq-generic driver instead of
a custom cpufreq driver, and I did the work to do that. So now I clearly
hope that cpufreq-generic will be merged in 3.17.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
