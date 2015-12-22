From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 22 Dec 2015 21:41:28 +0800
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
In-Reply-To: <1450791416.20501.7.camel@mtksdaap41>
References: <1450412497-25872-1-git-send-email-djkurtz@chromium.org>
 <CACRpkdbuL5Kjeqb-zJg9DmoxKzy7vphYgBTG-Ffh2i=UVH97ug@mail.gmail.com>
 <1450791416.20501.7.camel@mtksdaap41>
Message-ID: <CAGS+omCLEaD34eXLcQZ5q4Jt36d8Ksfg2SzfNNPxkgYrRQu0_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 9:36 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> On Tue, 2015-12-22 at 11:23 +0100, Linus Walleij wrote:
>> On Fri, Dec 18, 2015 at 5:21 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>
>> > Move pinctrl initialization earlier in boot so that real devices can find
>> > their pctldev without probe deferring.
>> >
>> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>>
>> I interpret the discussion as I should wait for a new version of this?
>>
>> Or should it be applied?
>
> We'll have another patch to change init orders for pwrap, mt6397 mfd
> core and mt6397 regulator. Before that, the mt6397 pinctrl changes in
> this patch won't work as expect. Apply this now won't cause any problem
> either, unless someone think we should stink to current orders.
>
> So I think we could apply this now:
>
> Acked-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> Joe.C

Joe.C, Linus,

Thanks for the Ack.
I think it is cleaner if I just send a new patch without the mt6397 change.
So, I'll do that in a bit.
