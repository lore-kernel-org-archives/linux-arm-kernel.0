From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 20 Dec 2013 09:36:41 -0500
Subject: [PATCH v2 0/2] gpio: davinci: reuse for keystone arch
In-Reply-To: <CACRpkdYcvtWNgJ=JCgpZFdZmypLu7UmtpyTQusRshSGT=EqsVg@mail.gmail.com>
References: <1387361272-20861-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdYcvtWNgJ=JCgpZFdZmypLu7UmtpyTQusRshSGT=EqsVg@mail.gmail.com>
Message-ID: <52B455F9.8070707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 December 2013 04:40 AM, Linus Walleij wrote:
> On Wed, Dec 18, 2013 at 11:07 AM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
>> This series is intended to update Davinci GPIO driver and reuse
>> it for Keystone SoCs, because Keystone uses the similar GPIO IP like Davinci.
>> Keystone GPIO IP: supports:
>> - up to 32 GPIO lines;
>> - only unbanked irqs;
>>
>> See Documentation:
>> Keystone - http://www.ti.com/lit/ug/sprugv1/sprugv1.pdf
>>
>> This series based on:
>> https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v3.14/gpio
>>
>> Changes in v2:
>> - minor comments applied, no functional changes
>>
>> v1: https://lkml.org/lkml/2013/12/12/366
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
Great !!

> For this v2 series.
> 
> Expecting this to go in through the DaVinci tree!
> 
Sekhar, Can you please include these to your DaVinci gpio branch ?

Regards,
Santosh
