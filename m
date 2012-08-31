From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 00:28:29 +0200
Subject: [PATCH 1/6] gpio/mxs: adopt irq_domain support for mxs gpio driver
In-Reply-To: <20120824010904.GN24242@S2101-09.ap.freescale.net>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
 <1345472400-31262-2-git-send-email-shawn.guo@linaro.org>
 <CACRpkdbSaa6ZOZYB1Cm7WjW0O51kvwsTAxhjefEKd-7XaBB3dw@mail.gmail.com>
 <20120824010904.GN24242@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdYhxxPw5Chw0U6gqc0cuSTpC5aMYV==dqbqBT=xnOO9Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 3:09 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, Aug 23, 2012 at 11:49:50PM +0200, Linus Walleij wrote:
>> On Mon, Aug 20, 2012 at 4:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>>
>> > Remove irq_domain_add_legacy call from mach-mxs.c and have the gpio
>> > driver adopt irqdomain support, so that we can have the mapping
>> > between gpio and irq number available without using virtual_irq_start
>> > and MXS_GPIO_IRQ_START.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> > Cc: Linus Walleij <linus.walleij@linaro.org>
>>
>> OK patch applied, thanks!
>>
> I was planning to have the patch to go via arm-soc tree with your ACK.
> But it also works to have it on gpio tree and I ask arm-soc people to
> pull gpio tree into arm-soc, but you need to ensure the branch is
> stable (no rebase).

OK sorry (and sorry for the delay) I took the patch out again, please take
this through your tree as needed.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours.
Linus Walleij
