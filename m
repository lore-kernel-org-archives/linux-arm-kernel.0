From: alex.shi@intel.com (Alex Shi)
Date: Fri, 14 Dec 2012 14:36:53 +0800
Subject: [RFC PATCH v2 3/6] sched: pack small tasks
In-Reply-To: <1355460356.5777.12.camel@marge.simpson.net>
References: <1355319092-30980-1-git-send-email-vincent.guittot@linaro.org>
 <1355319092-30980-4-git-send-email-vincent.guittot@linaro.org>
 <50C93AC1.1060202@intel.com>
 <CAKfTPtB9iz1ePsS+juQVRhuWREYB1duGWRJT7ya8XBXPhC-mkw@mail.gmail.com>
 <50C9E552.1010600@intel.com> <1355460356.5777.12.camel@marge.simpson.net>
Message-ID: <50CAC905.9070100@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2012 12:45 PM, Mike Galbraith wrote:
>> > Do you have further ideas for buddy cpu on such example?
>>> > > 
>>> > > Which kind of sched_domain configuration have you for such system ?
>>> > > and how many sched_domain level have you ?
>> > 
>> > it is general X86 domain configuration. with 4 levels,
>> > sibling/core/cpu/numa.
> CPU is a bug that slipped into domain degeneration.  You should have
> SIBLING/MC/NUMA (chasing that down is on todo).

Maybe.
the CPU/NUMA is different on domain flags, CPU has SD_PREFER_SIBLING.
