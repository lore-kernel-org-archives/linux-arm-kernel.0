From: j-keerthy@ti.com (Keerthy)
Date: Mon, 7 Aug 2017 18:08:32 +0530
Subject: [PATCH v2 2/3] gpio: davinci: Handle the return value of
 davinci_gpio_irq_setup function
In-Reply-To: <CACRpkdanDK338_eEKpekD39MedJKbCkFMtLbGske3QpTQKv28g@mail.gmail.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
 <1500543738-9696-3-git-send-email-j-keerthy@ti.com>
 <32ca2ace-bca3-4819-d3fb-10331cd0213c@ti.com>
 <CACRpkdanDK338_eEKpekD39MedJKbCkFMtLbGske3QpTQKv28g@mail.gmail.com>
Message-ID: <3fc67c9e-4a03-cda0-1cd1-02f995fd9ab2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 07 August 2017 05:42 PM, Linus Walleij wrote:
> On Wed, Aug 2, 2017 at 12:59 PM, Keerthy <j-keerthy@ti.com> wrote:
>> On Thursday 20 July 2017 03:12 PM, Keerthy wrote:
>>> Currently davinci_gpio_irq_setup return value is ignored. Handle the
>>> return value appropriately.
>>
>> Linus,
>>
>> Any comments on this? Sorry if i pinged too soon. The rest 2 of this
>> series were pulled by you. So just wanted to check on this one if you
>> had specific comments.
> 
> I got the impression you would send this in a series with a new
> patch requested by Johan.
> 
> Do we have consensus that this patch should be applied as-is?

IIUC a separate patch is needed to implement remove function. This can
still be independent of that.

https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1450395.html

> 
> Yours,
> Linus Walleij
> 
