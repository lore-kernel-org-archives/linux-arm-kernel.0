From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 19 Oct 2016 09:43:51 -0700
Subject: [PATCH v5 0/5] Add support for legacy SCPI protocol
In-Reply-To: <4aa21ebe-446e-6343-238c-515718cbb162@arm.com> (Sudeep Holla's
 message of "Wed, 19 Oct 2016 17:10:10 +0100")
References: <1476881472-13055-1-git-send-email-narmstrong@baylibre.com>
 <ff62da76-a7b9-6891-c198-f9049dfa7bb5@arm.com>
 <7h1szc9vnp.fsf@baylibre.com>
 <4aa21ebe-446e-6343-238c-515718cbb162@arm.com>
Message-ID: <7hpomw8f20.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> On 19/10/16 16:59, Kevin Hilman wrote:

[...]

>>
>> Sudeep, will this be an immutable branch? (or could you put a tag at an
>> immutable place on this branch?)  I'd like to include this in my amlogic
>> integration branch for broader testing.
>>
>
> If you plan to test SCPI(which is enabled in defconfig), then you need
> all the patches in the branch[1]. I will tag once I get a build success
> from kbuild robot and I do some testing. In short, immutable tag = PR
> tag IMO. The only thing I can drop from the list is DT bindings patch.
>
> Let me know if you are fine using the same tag ? Or you can propose any
> other alternative, I am fine by that too.

I'm currently using your scpi-updates/for-next branch, so a tag at (or
near) there should be fine after you've validated it.

Thanks,

Kevin
