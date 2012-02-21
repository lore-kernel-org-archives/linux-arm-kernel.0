From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 21 Feb 2012 22:39:46 +0800
Subject: [PATCH 2/2] ARM: perf: check that we have an event in the PMU IRQ
 handlers
In-Reply-To: <1329832775-11203-2-git-send-email-will.deacon@arm.com>
References: <1329832775-11203-1-git-send-email-will.deacon@arm.com>
 <1329832775-11203-2-git-send-email-will.deacon@arm.com>
Message-ID: <CACVXFVPgLHsky5Om0mBKUYvmi4wh_yqNr-ARe014CmXREXWMeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Tue, Feb 21, 2012 at 9:59 PM, Will Deacon <will.deacon@arm.com> wrote:
> The PMU IRQ handlers in perf assume that if a counter has overflowed
> then perf must be responsible. In the paranoid world of crazy hardware,
> this could be false, so check that we do have a valid event before
> attempting to dereference NULL in the interrupt path.
>
> Cc: Ming Lei <tom.leiming@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>
> Ming Lei - can I have your S-o-B for this please?

Sure,  Signed-off-by: Ming Lei <tom.leiming@gmail.com>


thanks,
-- 
Ming Lei
