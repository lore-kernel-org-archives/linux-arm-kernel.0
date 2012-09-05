From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 5 Sep 2012 10:32:07 +0530
Subject: [PATCH v3 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120905011219.GN2362@S2101-09.ap.freescale.net>
References: <1344577046-14847-1-git-send-email-shawn.guo@linaro.org>
 <1344577046-14847-4-git-send-email-shawn.guo@linaro.org>
 <201209050118.39045.rjw@sisk.pl>
 <20120905011219.GN2362@S2101-09.ap.freescale.net>
Message-ID: <CAMQu2gwjqhi2EJ_3yk+0k9gRWDaGu4yG+V7E4BJ2G3Ki7uGk6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Wed, Sep 5, 2012 at 6:42 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Sep 05, 2012 at 01:18:38AM +0200, Rafael J. Wysocki wrote:
>> On Friday, August 10, 2012, Shawn Guo wrote:
>> > It adds a generic cpufreq driver for CPU0 frequency management based on
>> > clk, regulator, OPP and device tree support.  It can support both
>> > uniprocessor (UP) and those symmetric multiprocessor (SMP) systems which
>> > share clock and voltage across all CPUs.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> I seem to recall that this has been discussed with several people and
>> undergone some changes as a result of comments.  Would it be possible
>> to get some ACKs from the people involved?
>>
>
> Mark, Santosh,
>
> Reviewed-by, please?
>
As commented already, the name of file was bit odd to me
otherwise, patch itself is fine by me.

FWIW ,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
