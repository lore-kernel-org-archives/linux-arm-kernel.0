From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 27 Mar 2015 12:21:45 +0200
Subject: gpio-syscon for Keystone 2 - DT bindings mismatch code
 expectation?
In-Reply-To: <CACRpkdYVkdLEEae8JHSsBEtMyhMx0yqN8RLhP2reoV+r5gA+JA@mail.gmail.com>
References: <20150323215545.GT8656@n2100.arm.linux.org.uk>
 <CACRpkdYVkdLEEae8JHSsBEtMyhMx0yqN8RLhP2reoV+r5gA+JA@mail.gmail.com>
Message-ID: <55152F39.5090805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2015 12:12 PM, Linus Walleij wrote:
> On Mon, Mar 23, 2015 at 10:55 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>
>> Linus, Grygorii,
>>
>> I'm trying to understand what's happening to make Keystone2 print
>> this at boot:
>>
>> gpio-syscon soc:keystone_dsp_gpio at 02620240: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 2620244: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 2620248: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 262024c: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 2620250: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 2620254: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 2620258: can't read the dir register offset!
>> gpio-syscon soc:keystone_dsp_gpio at 262025c: can't read the dir register offset!
>
> Grygorii are you looking into this?

Yes. Seems you've found the patch already )
https://lkml.org/lkml/2015/3/24/908

regards,
-grygorii
