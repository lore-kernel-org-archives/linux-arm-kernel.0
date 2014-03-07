From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Mar 2014 11:56:11 +0800
Subject: [PATCH 3/3] pinctrl: mvebu: silence WARN to dev_warn
In-Reply-To: <20140307035056.GQ1872@titan.lakedaemon.net>
References: <1393977790-29110-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393977790-29110-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140306201803.GL1872@titan.lakedaemon.net>
 <CACRpkda0JCLZUv_KPmwucDh3ko2YbtG2ukMMscSodAbBpiY+zw@mail.gmail.com>
 <20140307035056.GQ1872@titan.lakedaemon.net>
Message-ID: <CACRpkdbEQSj7jLWT2BFR22m7phwmyKCByhQuFFgHvHoKvQFD5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 7, 2014 at 11:50 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Mar 07, 2014 at 11:48:25AM +0800, Linus Walleij wrote:
>> On Fri, Mar 7, 2014 at 4:18 AM, Jason Cooper <jason@lakedaemon.net> wrote:
>> > On Wed, Mar 05, 2014 at 01:03:10AM +0100, Sebastian Hesselbarth wrote:
>> >> Pinctrl will WARN on missing DT resources, which is a little bit too
>> >> noisy. Use dev_warn with FW_BUG instead.
>> >>
>> >> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> >> ---
>> >> Cc: Russell King <linux@arm.linux.org.uk>
>> >> Cc: Jason Cooper <jason@lakedaemon.net>
>> >> Cc: Andrew Lunn <andrew@lunn.ch>
>> >> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>> >> Cc: Linus Walleij <linus.walleij@linaro.org>
>> >> Cc: devicetree at vger.kernel.org
>> >> Cc: linux-arm-kernel at lists.infradead.org
>> >> Cc: linux-kernel at vger.kernel.org
>> >> ---
>> >>  drivers/pinctrl/mvebu/pinctrl-dove.c | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >
>> > Applied to mvebu/pinctrl
>>
>> So are you carrying this patch, or shall I apply it to my tree?
>>
>> In the former case: Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I'll send you a pull tomorrow.

For a single patch?

Remember I want the DTS changes to go to ARM SoC on some different
pull...

Yours,
Linus Walleij
