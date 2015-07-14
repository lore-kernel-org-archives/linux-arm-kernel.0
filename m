From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jul 2015 09:53:02 +0200
Subject: [PATCH v2 5/8] ARM: dts: add i.mx6ul pin function include file
In-Reply-To: <20150714011617.GA3264@tiger>
References: <1434727951-4852-1-git-send-email-Frank.Li@freescale.com>
 <1434727951-4852-6-git-send-email-Frank.Li@freescale.com>
 <CACRpkdbgKhXgcnncrHKDPC1hC1QEdhTyxFH61J4vG8ftoasHPQ@mail.gmail.com>
 <20150714011617.GA3264@tiger>
Message-ID: <CACRpkdbwHD02QMxrOH4hM3FuiWiLVPrmTW7XOPbjijK4L8Adew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 3:16 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Jul 13, 2015 at 10:40:57PM +0200, Linus Walleij wrote:
>> On Fri, Jun 19, 2015 at 5:32 PM,  <Frank.Li@freescale.com> wrote:
>>
>> > From: Frank Li <Frank.Li@freescale.com>
>> >
>> > add pin mux define file
>> >
>> > Signed-off-by: Bai Ping <b51503@freescale.com>
>> > Signed-off-by: Anson Huang <b20788@freescale.com>
>> > Signed-off-by: Frank Li <Frank.Li@freescale.com>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Are you taking this through the ARM SoC tree?
>
> Yes, I plan to take it via IMX tree.

OK awesome. I put the pinctrl subdriver patch into the pinctrl
tree, it should work to merge them orthogonally, if you see any
problems then tell me.

Yours,
Linus Walleij
