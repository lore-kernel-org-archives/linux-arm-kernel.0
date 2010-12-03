From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 3 Dec 2010 15:14:38 -0800
Subject: [PATCH] ARM: iop: ensure sched_clock() is notrace
In-Reply-To: <1290182785-22352-4-git-send-email-rabin@rab.in>
References: <1290182785-22352-4-git-send-email-rabin@rab.in>
Message-ID: <AANLkTintL7bCYF6SwSATZxXVX+WH+9QzsyNH+TsqznMJ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 8:06 AM, Rabin Vincent <rabin@rab.in> wrote:
> Include sched.h to ensure sched_clock() has the notrace
> annotation, and mark any functions it calls as notrace
> too.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Dan Williams <dan.j.williams@intel.com>

This can go to Russell's tracker.
