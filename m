From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sun, 24 May 2015 21:00:37 +0200
Subject: [PATCH] ARM: BCM5301X: activate some additional options in pl310
 cache controller
In-Reply-To: <CACna6ryXjmEgw+dzz5OgS=9rUn8ng9S6rD7eBoQ8dqycG5vJ9Q@mail.gmail.com>
References: <1432493418-12933-1-git-send-email-hauke@hauke-m.de>
 <CACna6ryXjmEgw+dzz5OgS=9rUn8ng9S6rD7eBoQ8dqycG5vJ9Q@mail.gmail.com>
Message-ID: <55621FD5.8010408@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2015 08:54 PM, Rafa? Mi?ecki wrote:
> On 24 May 2015 at 20:50, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> In the default Broadcom SDK the shared override is activated for this
>> cache controller, do the same in the upstream code. Data and
>> instruction prefetching is not activated by default for this cache
>> controller on the bcm53xx SoC, do it manually like it is done in the
>> vendor SDK.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  arch/arm/boot/dts/bcm5301x.dtsi | 3 +++
>>  1 file changed, 3 insertions(+)
>>
This makes use of the attributes added by these two patches:

http://www.spinics.net/lists/arm-kernel/msg416406.html
http://www.spinics.net/lists/arm-kernel/msg418996.html

I hope both patches will make it into 4.2, but there wasn't a negative
comment in the last week.

Hauke
