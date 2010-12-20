From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 20 Dec 2010 11:32:21 +0800
Subject: [PATCH 0/40] Complete set of clocksource/sched_clock patches
In-Reply-To: <20101217113223.GC9937@n2100.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimarRAf-_ykQNLgzXd3TtUHhSw+gZ6cZ5pW=Y-9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 7:32 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Here is the entire set of clocksource and sched_clock patches which
> have been previously posted. ?There's a couple of small tweaks in a
> few of the patches (such as adding notrace to OMAP clocksource read
> functions), and this also shows the proper ordering of these patches.
>
> Still looking for acks or tested-by's for these patches.
>

Hi Russell,

Sorry for late feedback. Tested the branch 'clksrc' on Littleton/PXA3xx,
seems to be good.

Tested-by: Eric Miao <eric.y.miao@gmail.com>
