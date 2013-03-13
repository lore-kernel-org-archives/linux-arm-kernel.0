From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 23:44:04 +0800
Subject: [PATCH v3 03/11] clocksource: sp804: add device tree support
In-Reply-To: <1363189308.3100.104.camel@hornet>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-4-git-send-email-haojian.zhuang@linaro.org>
 <1363172730.3100.17.camel@hornet> <51408A71.9090501@gmail.com>
 <1363185757.3100.66.camel@hornet> <51409276.8050601@gmail.com>
 <1363186548.3100.75.camel@hornet>
 <CAD6h2NTP+X6RVr23Y-XLrQMqHptH974oYooTX=Y6F_Q4hyrmNA@mail.gmail.com>
 <1363188238.3100.95.camel@hornet>
 <CAD6h2NR+SC4cN5cBzHUNBfDQ1=x8Rbn3C4AizNyy562iMjyU6A@mail.gmail.com>
 <1363188595.3100.101.camel@hornet> <51409DBD.5080209@gmail.com>
 <1363189308.3100.104.camel@hornet>
Message-ID: <CAD6h2NQEin1uZczh3kCD660x7U68RUmT16rHit1epaNL3V+S2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 23:41, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2013-03-13 at 15:39 +0000, Rob Herring wrote:
>> I previously described that to add a property in that case. That makes
>> INT1 and INT2 only handling asymetric though. An alternative would be an
>> optional property "arm,sp804-has-irq = <#>" in the case of only INT1 or
>> INT2 connected. The combined irq would be a single irq without the
>> "arm,sp804-has-irq" property and both connected would be 2 irqs.
>
> Fine with me.
>
> Pawe?
>
>

It's OK to me. I can use this property instead.

Regards
Haojian
