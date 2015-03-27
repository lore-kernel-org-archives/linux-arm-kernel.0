From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 11:12:24 +0100
Subject: gpio-syscon for Keystone 2 - DT bindings mismatch code
 expectation?
In-Reply-To: <20150323215545.GT8656@n2100.arm.linux.org.uk>
References: <20150323215545.GT8656@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYVkdLEEae8JHSsBEtMyhMx0yqN8RLhP2reoV+r5gA+JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 10:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Linus, Grygorii,
>
> I'm trying to understand what's happening to make Keystone2 print
> this at boot:
>
> gpio-syscon soc:keystone_dsp_gpio at 02620240: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 2620244: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 2620248: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 262024c: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 2620250: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 2620254: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 2620258: can't read the dir register offset!
> gpio-syscon soc:keystone_dsp_gpio at 262025c: can't read the dir register offset!

Grygorii are you looking into this?

Yours,
Linus Walleij
