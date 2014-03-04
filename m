From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Tue, 4 Mar 2014 13:28:43 +0200
Subject: [RESEND][PATCH v4] gpio: davinci: reuse for keystone soc
In-Reply-To: <CACRpkda=+vnOEfGeZNS7+7WXU4v29gfQYY0xoc8d-sFEfrWqUw@mail.gmail.com>
References: <52FBB6BC.2060801@ti.com>	<1392307125-27927-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkda=+vnOEfGeZNS7+7WXU4v29gfQYY0xoc8d-sFEfrWqUw@mail.gmail.com>
Message-ID: <5315B8EB.40806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 11:20 AM, Linus Walleij wrote:
> On Thu, Feb 13, 2014 at 4:58 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
>
>> The similar GPIO HW block is used by keystone SoCs as
>> in Davinci SoCs.
>> Hence, reuse Davinci GPIO driver for Keystone taking into
>> account that Keystone contains ARM GIC IRQ controller which
>> is implemented using IRQ Chip.
>>
>> Documentation:
>>          http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>
> Applied! Santosh hunted me down in person so it really happened this
> time...

Thanks a lot :)

>
> Yours,
> Linus Walleij
>
