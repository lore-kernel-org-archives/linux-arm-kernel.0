From: afd@ti.com (Andrew F. Davis)
Date: Tue, 1 Nov 2016 14:20:58 -0500
Subject: [PATCH v12 RESEND 0/4] generic TEE subsystem
In-Reply-To: <20161028181914.xkse5orwwp42dvj3@sirena.org.uk>
References: <1477649984-16777-1-git-send-email-jens.wiklander@linaro.org>
 <1e532aeb-4944-62e4-c8c4-1e23438b92cd@ti.com>
 <20161028181914.xkse5orwwp42dvj3@sirena.org.uk>
Message-ID: <4eb80778-cfe3-f4c0-d1ee-0d798c8ddd35@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2016 01:19 PM, Mark Brown wrote:
> On Fri, Oct 28, 2016 at 10:43:24AM -0500, Andrew F. Davis wrote:
> 
>> Do we see this as a chicken and egg situation, or is there any harm
>> beyond the pains of supporting an out-of-tree driver for a while, to
>> wait until we have at least one other TEE to add to this subsystem
>> before merging?
> 
> We haven't been overburneded with TEE vendors wanting to get their
> driver code into mainline - do we have any reasonable prospect of other
> TEE vendors with an interest in mainline turning up in any kind of
> reasonable timeframe?
> 

Doesn't look like anyone has near-term plans for upstreaming non-OPTEE
TEEs, we don't at least (TI), so I guess I see no reason right now to
delay upstreaming of this TEE's driver on the off-chance it is
incompatible with a TEE that may or may not try to get upstreamed later.
I'll redact my objection for now.
