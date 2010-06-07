From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 7 Jun 2010 17:31:46 +0800
Subject: [PATCH] RTC/pxa: remove unnecessary private ops->ioctl()
In-Reply-To: <877hmbcjqu.fsf@free.fr>
References: <4C0A5F53.6070600@gmail.com> <877hmbcjqu.fsf@free.fr>
Message-ID: <AANLkTik8kwpB1rdGU6oSqP9f_sREGPapku7XtrQfgOWp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 7, 2010 at 4:47 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Wan ZongShun <mcuos.com@gmail.com> writes:
>> Please, do not implement private ops->ioctl() unless absolutely necessary.
>> pxa series RTC driver's ioctl() is unnecessary, since RTC subsystem has implement
>> the ioctl() very well,so we can only use the API of '.alarm_irq_enable' and
>> '.update_irq_enable' to do enable irq action.
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> This is not an urgent fix, but a cleanup. Whoever gets it in (Alessandro through
> rtc tree, Eric through arm/pxa tree, or Andrew) is to be defined.
>
> I would go for Alessandro, as he handles the RTC tree.
>

Yeah, Acked-by: Eric Miao <eric.y.miao@gmail.com>
