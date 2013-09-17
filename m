From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Sep 2013 17:41:06 -0700
Subject: [PATCH] ARM: kvm: rename cpu_reset to avoid name clash
In-Reply-To: <20130912015002.GO9860@cbox>
References: <1378938461-10835-1-git-send-email-olof@lixom.net>
 <CAOesGMjum0TSyudXiZtXHOGX4R7dBAhjUpoYnwjTcfD1MMpTxw@mail.gmail.com>
 <20130912015002.GO9860@cbox>
Message-ID: <CAOesGMiGaM=s85iKHPXd9eBiL1vy3SVws+KR0ToxPpZeiisscg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 11, 2013 at 6:50 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Wed, Sep 11, 2013 at 03:39:26PM -0700, Olof Johansson wrote:
>> On Wed, Sep 11, 2013 at 3:27 PM, Olof Johansson <olof@lixom.net> wrote:
>> > cpu_reset is already #defined in <asm/proc-fns.h> as processor.reset,
>> > so it expands here and causes problems.
>> >
>> > Signed-off-by: Olof Johansson <olof@lixom.net>
>>
>> I just noticed this is broken on 3.10 too, so if/when applying feel free to add:
>>
>> Cc: <stable@vger.kernel.org> # 3.10+
>>
> Thanks for the fix, applied.

I haven't seen this hit linux-next yet?


-Olof
