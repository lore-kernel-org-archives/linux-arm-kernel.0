From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 16 Jul 2014 21:02:29 +0530
Subject: [PATCH 2/8] cpufreq: add driver for Armada XP
In-Reply-To: <20140716172811.2289a64c@free-electrons.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
 <20140716160256.7e8dbccf@free-electrons.com>
 <CAKohpomaYfuq0CR5xsf73obTbXsxdBtHToLsNWcW2NQcCd5LUw@mail.gmail.com>
 <20140716172811.2289a64c@free-electrons.com>
Message-ID: <CAKohpok6-_7aQ1RxSJKLo1idc777LHWLVM=tjtTLOzZjeAUpjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 July 2014 20:58, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> I guess you meant 3.17, right?

Yeah, sorry.

> Would be good to have this soon, since the 3.17 merge window is
> approaching. You asked me to use this cpufreq-generic driver instead of
> a custom cpufreq driver, and I did the work to do that. So now I clearly
> hope that cpufreq-generic will be merged in 3.17.

Yeah, I have already pinged Rafael few days back on this. He came back
from holidays last week and this is what he told me:

Jul 11 19:58:34 <vireshk> rafael, when are you going to pick stuff for 3.17?
Jul 11 19:59:11 <rafael> vireshk: next week i suppose


Do you depend on this patch btw?

https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg675398.html

Actually there had been some objections to comparing clocks this way and
we *might* hold this off, unless the bindings are finalized. Will get all other
patches merged though.
