From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 13 Mar 2014 10:41:45 -0700
Subject: [PATCH v2 6/6] PCI: designware: use new OF interrupt mapping when
 possible
In-Reply-To: <201403061633.31260.marex@denx.de>
References: <1394025951-32438-1-git-send-email-l.stach@pengutronix.de>
 <1394025951-32438-7-git-send-email-l.stach@pengutronix.de>
 <000201cf38e6$5b02d6e0$110884a0$%han@samsung.com>
 <201403061633.31260.marex@denx.de>
Message-ID: <CAJ+vNU2XrAL+BTTB8i4hQhkZ_NfcS0VrWuHUjeFfU9hhGjNXbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 6, 2014 at 7:33 AM, Marek Vasut <marex@denx.de> wrote:
> On Thursday, March 06, 2014 at 03:47:03 AM, Jingoo Han wrote:
>> On Wednesday, March 05, 2014 10:26 PM, Lucas Stach wrote:
>> > This is the recommended method of doing the IRQ
>> > mapping. For old devicetrees we fall back to the
>> > previous practice.
>> >
>> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> (+cc Mohit KUMAR, Richard Zhu, Pratyush Anand, Marek Vasut,
>>        Kishon Vijay Abraham I)
>>
>> Acked-by: Jingoo Han <jg1.han@samsung.com>
>>
>> It works properly on Exynos platform.
>> Thank you.
>
> Looks reasonable,
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>

I've tested this on the Gateworks Ventana products with P2P bridges
and with the patch I just submitted here:
http://thread.gmane.org/gmane.linux.kernel.pci/30017

Tested-by: Tim Harvey <tharvey@gateworks.com>

Tim
