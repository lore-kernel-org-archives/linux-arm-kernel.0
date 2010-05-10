From: jassisinghbrar@gmail.com (jassi brar)
Date: Mon, 10 May 2010 21:50:27 +0900
Subject: [FOR RMK] PL330: Add common core driver
In-Reply-To: <q2r63386a3d1005071200lbf191c40r6efabbefbf93a353@mail.gmail.com>
References: <1272685028-14295-1-git-send-email-jassisinghbrar@gmail.com>
	<q2r63386a3d1005071200lbf191c40r6efabbefbf93a353@mail.gmail.com>
Message-ID: <AANLkTimGXCuDmovVNJWNC-X_5ICCqUHI-Zi9N8U71qTL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 8, 2010 at 4:00 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/5/1 Jassi Brar <jassisinghbrar@gmail.com>:
>
>> From: Jassi Brar <jassi.brar@samsung.com>
>>
>> PL330 is a configurable DMA controller PrimeCell device.
>> The register map of the device is well defined.
>> The configuration of a particular implementation can be
>> read from the six configuration registers CR0-4,Dn.
>>
>> This patch implements a driver for the specification:-
>> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0424a/DDI0424A_dmac_pl330_r0p0_trm.pdf
>>
>> The exported interface should be sufficient to implement
>> a driver for any DMA API.
>>
>> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>

Hi Russell,
 I was not sure if the patch is acceptable to you, I have
submitted it to your patch tracking system.

Not sure if that's the right procedure, but I hope I get your
opinion and some direction forward.

Thanks
