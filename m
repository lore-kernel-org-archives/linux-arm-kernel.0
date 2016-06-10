From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 10 Jun 2016 15:11:15 -0700
Subject: [PATCH] ARM: bcm2835: remove unused __packet
In-Reply-To: <87shwo68su.fsf@eliezer.anholt.net> (Eric Anholt's message of
 "Tue, 07 Jun 2016 13:30:41 -0700")
References: <1465321773-21519-1-git-send-email-ben.dooks@codethink.co.uk>
 <87shwo68su.fsf@eliezer.anholt.net>
Message-ID: <m27fdwy9rw.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Anholt <eric@anholt.net> writes:

> Ben Dooks <ben.dooks@codethink.co.uk> writes:
>
>> The driver defines a variable called __packet but then never
>> uses it, and does not export it for others to use either. Fix
>> the warning about undeclared variable by removing it.
>>
>> drivers/soc/bcm/raspberrypi-power.c:48:3: warning: symbol '__packet' was not declared. Should it be static?
>
> Reviewed-by: Eric Anholt <eric@anholt.net>
>
> PM folks: I'd be happy to see this go through your trees, but either way
> is fine with me.

Since this is in drivers/soc, just include it in your cleanup branch for
arm-soc.

Kevin
