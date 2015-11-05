From: pinskia@gmail.com (Andrew Pinski)
Date: Thu, 5 Nov 2015 21:39:51 +0800
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <mvm7flw3cfu.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <mvm7flw3cfu.fsf@hawking.suse.de>
Message-ID: <CA+=Sn1n4-mdTvyiXKpVj9509MrJWGpCeWdGJWcTSU9n2R8PVkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 5, 2015 at 7:36 PM, Andreas Schwab <schwab@suse.de> wrote:
> Yury Norov <ynorov@caviumnetworks.com> writes:
>
>> v6:
>>  - time_t, __kenel_off_t and other types turned to be 32-bit
>>    for compatibility reasons (after v5 discussion);
>
> Are the updated glibc patches available somewhere?

Not in an useful form right now but i will try to get them in an
useful form sometime next week.  I am traveling home on Saturday.

Thanks,
Andrew

>
> Andreas.
>
> --
> Andreas Schwab, SUSE Labs, schwab at suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
