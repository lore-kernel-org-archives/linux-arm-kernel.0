From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 25 Jul 2015 07:59:42 +0200
Subject: [PATCH] watchdog: sunxi: fix activation of system reset
In-Reply-To: <20150720082658.GU28632@lukather>
References: <559AC20B.4090601@gmail.com> <20150720082658.GU28632@lukather>
Message-ID: <55B325CE.6080703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 07/20/2015 10:26 AM, Maxime Ripard wrote:
> Hi Francesco,
>
> Your patch looks mostly good, but there's just a few minor things.
>
> On Mon, Jul 06, 2015 at 07:59:39PM +0200, Francesco Lavra wrote:
>> Commit f2147de3 ("watchdog: sunxi: support parameterized compatible
>
> The commit ID should have at least 12 chars to avoid future ID
> collisions (which already start to happen)

Will do.

>> strings") introduced a regression in sunxi_wdt_start(), by which
>> the system reset function of the watchdog is not enabled upon
>> starting the watchdog. Fix it.
>
> Having a description of what that actually means for the end-user (I
> guess that it won't reset the system when the watchdog expires) would
> be nice.

Fair enough.

>> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
>
> Could you also CC stable, and add a Fixes: tag please?

Sure, a V2 patch will follow shortly.

> Thanks,
> Maxime
