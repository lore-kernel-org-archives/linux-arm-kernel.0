From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 28 Aug 2009 08:54:03 +0900
Subject: 6410 issues with samsung-ap-2.6
In-Reply-To: <20090827204650.48cb46f1@taxman.wild-wind.fr.eu.org>
References: <200908242149.n7OLnU6d017655@chronolytics.com>
	<20090827204650.48cb46f1@taxman.wild-wind.fr.eu.org>
Message-ID: <9c9fda240908271654v57bb1b18q6ef6707552d2dcb2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, Aug 28, 2009 at 3:46 AM, Marc Zyngier<maz@misterjones.org> wrote:
> On Mon, 24 Aug 2009 17:49:30 -0400 (EDT)
> "David F. Carlson" <dave@chronolytics.com> wrote:
>
>> I am having trouble with the the input gpio_keys code that does a
>> "gpio_to_irq()" to get the gpio to irq mapping.
>>
>> This call always fails for the 6410 (ENXIO). ?I see no code for the
>> 6410 to get a irq.
>
> Just checked in mainline, and there is support there for gpio_to_irq(),
> at least for gpio bank N. It shouldn't be too hard to add support for
> the two remaining banks.
>

Right, it's not hard to add. It will be supported.
Internally it's tested and works well.

Thank you,
Kyungmin Park
