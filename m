From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 23 Jan 2017 14:59:42 +0100
Subject: [PATCH] tcb_clksrc: Use 32 bit tcb as sched_clock
In-Reply-To: <20170111135059.21318-1-david.engraf@sysgo.com>
References: <20170111135059.21318-1-david.engraf@sysgo.com>
Message-ID: <20170123135942.GC2166@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 02:50:59PM +0100, David Engraf wrote:
> On newer boards the TC can be read as single 32 bit value without locking.
> Thus the clock can be used as reference for sched_clock which is much more
> accurate than the jiffies implementation.
> 
> Tested on a Atmel SAMA5D2 board.
> 
> Signed-off-by: David Engraf <david.engraf@sysgo.com>
> ---

Nicolas,

if you agree I will take this change.

  -- Daniel
