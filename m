From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 May 2018 14:12:04 +0100
Subject: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
In-Reply-To: <20180509161120.ilnukvismwfb452g@lakrids.cambridge.arm.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
 <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
 <1525882003.4199.55.camel@arm.com>
 <20180509161120.ilnukvismwfb452g@lakrids.cambridge.arm.com>
Message-ID: <1526044324.3315.88.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apologies about delay - I was away yesterday. And advance apologies
about - most likely - not participating in discussions in the next 4
weeks, but I'll be on holiday in rather remote areas.

On Wed, 2018-05-09 at 17:12 +0100, Mark Rutland wrote:
> True. I'll reword the above to:
> 
>   The ARM CCN PMU driver uses dev_warn() to complain about parameters
> in
>   the user-provided perf_event_attr. This means that under normal
>   operation (e.g. a single invocation of the perf tool), a number of
>   messages warnings may be logged to dmesg.
> 
> ... with that, can I take your ack?

I'm by no means enthusiastic nor happy about this change, so I'd rather
say "you won't get my NAK" (although even this wouldn't matter much, I
believe...)

Pawe?
