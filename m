From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 11 Mar 2014 14:08:25 +0100
Subject: [RFC 0/6] rework sched_domain topology description
In-Reply-To: <CAKfTPtCspVk+X3O23ikTt3MZUHVrrp21PyhmrcLF-GwW3OjOqA@mail.gmail.com>
References: <1394003906-11630-1-git-send-email-vincent.guittot@linaro.org>
 <5317B092.7070805@arm.com>
 <CAKfTPtDGbT717Y5F1GoBgr4pnvApG5Gphu2Me_bAFrM0+qsfAg@mail.gmail.com>
 <53186A8A.9060406@arm.com>
 <CAKfTPtCspVk+X3O23ikTt3MZUHVrrp21PyhmrcLF-GwW3OjOqA@mail.gmail.com>
Message-ID: <20140311130825.GX9987@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 10:47:49AM +0800, Vincent Guittot wrote:
> Peter,
> 
> Was the use of the cpu as a parameter in the initialization of
> sched_domain's flag a reason for asking for reworking the
> initialization of sched_domain ?

/me tries very hard to remember.. and fails.

Reading back the linked thread also doesn't seem to jog memory.
