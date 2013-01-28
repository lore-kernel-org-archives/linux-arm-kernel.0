From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 21:56:47 +0100
Subject: [PATCH v2] ARM: versatile: fix the PCI IRQ regression
In-Reply-To: <201301282016.BAG95395.VMOFFFQSHLOtJO@I-love.SAKURA.ne.jp>
References: <1359328750-28046-1-git-send-email-linus.walleij@linaro.org>
 <201301282016.BAG95395.VMOFFFQSHLOtJO@I-love.SAKURA.ne.jp>
Message-ID: <CACRpkda-JsW05dyEbxAM3CiPjpErBWgq8YZyt2hzGV1qxhaBgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 12:16 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:

> Linus Walleij wrote:
>> ---
>> ChangeLog v1->v2:
>> - Got the PIC/SIC valid mask wrong again, take a deep breath
>>   and use the foolproof method of defining each bit so that
>>   nobody will get caught by this again. Didn't see this first
>>   because the SCSI layer takes for ever to time out.
>> ---
>>  arch/arm/mach-versatile/core.c | 15 ++++++++++++++-
>>  arch/arm/mach-versatile/pci.c  | 11 ++++++-----
>>  2 files changed, 20 insertions(+), 6 deletions(-)
>>
>
> This patch fixes my problem. Please send to 3.8. Thank you!

OK will put this into Russell's patch tracker, thanks!

Yours,
Linus Walleij
