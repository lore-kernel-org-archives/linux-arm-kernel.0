From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:00:47 +0200
Subject: [PATCH 26/63] dmaengine: ste_dma40: Supply full Device Tree
 parsing support
In-Reply-To: <CACRpkdaj0RcZUJ9DX8D1v-MKecFs6ZwGjqD2gqaSFvP9QCbgGA@mail.gmail.com>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-27-git-send-email-lee.jones@linaro.org>
 <CACRpkdaj0RcZUJ9DX8D1v-MKecFs6ZwGjqD2gqaSFvP9QCbgGA@mail.gmail.com>
Message-ID: <CACRpkdbB6mN6XTyceCZO9j6rAPawdTijM11-ws-23tnamGYz5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 10:59 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
>
>> Using the new DMA DT bindings and API, we can register the DMA40 driver
>> as Device Tree capable. Now, when a client attempts to allocate a
>> channel using the DMA DT bindings via its own node, we are able to parse
>> the request and allocate a channel in the correct manner.
>>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: Dan Williams <djbw@fb.com>
>> Cc: Per Forlin <per.forlin@stericsson.com>
>> Cc: Rabin Vincent <rabin@rab.in>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Applied to my ux500-dma40 branch.

But hmmm would be really nice to have Vinod's ACK on this
patch as well.

Yours,
Linus Walleij
