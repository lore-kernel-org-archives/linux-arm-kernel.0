From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 17:04:53 +0800
Subject: [PATCH V3 1/4] Input: pxa27x_keypad keep clock on as wakeup source
In-Reply-To: <CAN1soZyBPE3YExELmu5yHeMTWQf9Zs07v26F6Qz3ocKO+cXGFw@mail.gmail.com>
References: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
 <CAN1soZyBPE3YExELmu5yHeMTWQf9Zs07v26F6Qz3ocKO+cXGFw@mail.gmail.com>
Message-ID: <CAN1soZxTfp9p-JoTmXRDFYLKt0mmgcSwc5F9Tk8b+E0fQRW6AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 2, 2012 at 5:37 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> On Sun, Apr 1, 2012 at 10:08 AM, Chao Xie <chao.xie@marvell.com> wrote:
>> When the keypad is used as wake up source, the clock can not
>> be disabled. Or it can not detect key pressing.
>> If the keypad is used as wake up source, when resume back,
>> do not enable the clock and configure it again because the
>> register content is retained.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>
> Hi Dmitry,
>
> I just found that you're not looped in this mail thread. Could I merge
> them into arch-pxa tree?
>
> Best Regards
> Haojian

Applied

Regards
Haojian
