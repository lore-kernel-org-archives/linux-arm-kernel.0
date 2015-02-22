From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 22 Feb 2015 15:34:05 +0100
Subject: [RFC PATCH 1/3] eeprom: Add a simple EEPROM framework
In-Reply-To: <54E86CA5.2080907@linaro.org>
References: <1424365639-26634-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424365708-26681-1-git-send-email-srinivas.kandagatla@linaro.org>
 <CAL_Jsq+SeuoojgTpv1y_aPJ_jzDr3HqZhYEBQ3_vYGBHvcccug@mail.gmail.com>
 <54E78A31.9020306@linaro.org>
 <CAL_Jsq+mvpRjYfL_8OseTDCB-6aBhwhNKLBQXXJeVQLDwWm8Nw@mail.gmail.com>
 <54E86CA5.2080907@linaro.org>
Message-ID: <20150222143405.GY25269@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 21, 2015 at 11:31:49AM +0000, Srinivas Kandagatla wrote:
> >I would do something more simple that is just a list of keys and their
> >location like this:
> >
> >device-serial-number = <start size>;
> >key1 = <start size>;
> >key2 = <start size>;
> >
> There are pros and cons doing it as list of keys.
> 
> One reason for doing it as fixed properties("eeproms", "eemprom-names") is
> "consistency and familiarity" like interrupts, regs, dmas, clocks, pinctrl,
> reset, pwm have fixed property names, trying to get most subsystems to do it
> the same way makes it easier for people to write dts files.

And eeprom-names was something that was asked for last time we
discussed it (I don't really remember who though, maybe Arnd?)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150222/3f111f7d/attachment.sig>
