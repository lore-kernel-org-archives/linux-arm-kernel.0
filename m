From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 14:34:05 +0200
Subject: [PATCH 0/6] Various ux500 crypto updates
In-Reply-To: <20130625111718.GA18551@gondor.apana.org.au>
References: <1372150489-25594-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdYgZ5ZSwDBfV8FRRqGcv09JiFyNq18vqO_dbxbhJ6_x4w@mail.gmail.com>
 <20130625111718.GA18551@gondor.apana.org.au>
Message-ID: <CACRpkdaVAbdMANkrqo2TK=z3JQ=KTdRxhR0f7zLTomuC7FFUrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 1:17 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Jun 25, 2013 at 11:20:50AM +0200, Linus Walleij wrote:
>> On Tue, Jun 25, 2013 at 10:54 AM, Fabio Baltieri
>> <fabio.baltieri@linaro.org> wrote:
>>
>> > these are some fixes to issue pointed out by sparse and dmaengine API
>> > udpates on the recently enabled ux500 hw crypto drivers.
>>
>> The series:
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> > These are based on recent linux-next, and can probably be applied on an
>> > architecture specific branch with your ack, or just skip to the next
>> > merge window.
>>
>> I think these depend on the DMA40 fixes that reside in the ARM SoC
>> tree. If I get Herbert's ACK I can queue them.
>
> Sure,
>
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

OK I'll attempt to queue this up and send it to ARM SoC.

Yours,
Linus Walleij
