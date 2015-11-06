From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Fri, 06 Nov 2015 15:49:25 +0100
Subject: [PATCH 04/10] pwm: core: use bitops
In-Reply-To: <20151106144635.GA8418@ulmo>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
 <20151106144635.GA8418@ulmo>
Message-ID: <563CBDF5.50904@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Thierry,

but why have the bit macro at all then :)

But that choice I guess I leave to you, as it's your section, I know 
some submaintainers prefer it and want it to be used, so I guess it's 
something in general kernel wide that should be desided on, BIT() macro 
preferred or not.

Olliver

On 06-11-15 15:46, Thierry Reding wrote:
> On Mon, Oct 26, 2015 at 10:32:35PM +0100, Olliver Schinagl wrote:
>> From: Olliver Schinagl <oliver@schinagl.nl>
>>
>> The pwm header defines bits manually while there is a nice bitops.h with
>> a BIT() macro. Use the BIT() macro to set bits in pwm.h
>>
>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>> ---
>>   include/linux/pwm.h | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> I don't think this is a useful change. The BIT() macro needs the same
> number of characters to type at the expense of requiring an additional
> include.
>
> Thierry

-- 
Met vriendelijke groeten, Kind regards, ??????

Olliver Schinagl
Software Engineer
Research & Development
Ultimaker B.V.
