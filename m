From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Jan 2015 01:00:16 +0100
Subject: [PATCH v3 2/3] pinctrl: add driver for Amlogic Meson SoCs
In-Reply-To: <20141127223402.GA11418@gmail.com>
References: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
 <1416168856-12747-3-git-send-email-b.galvani@gmail.com>
 <CACRpkda-U5OuKdBVGJ8UWprJkAtmTL1m11+AbNskVULPfyS72A@mail.gmail.com>
 <20141127223402.GA11418@gmail.com>
Message-ID: <CACRpkdY0tv77GgOF91EG8wEzsgQ4OsLUjogNxFjO-rjfY2Q15g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:34 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> On Thu, Nov 27, 2014 at 02:48:31PM +0100, Linus Walleij wrote:
>> On Sun, Nov 16, 2014 at 9:14 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
>>
>> > This is a driver for the pinmux and GPIO controller available in
>> > Amlogic Meson SoCs. At the moment it only supports Meson8 devices,
>> > however other SoC families like Meson6 and Meson8b (the Cortex-A5
>> > variant) appear to be similar, with just different sets of banks and
>> > registers.
>> >
>> > GPIO interrupts are not supported at the moment due to lack of
>> > documentation.
>> >
>> > Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
>>
>> This is dependent on S?ren's patches I guess?
>>
>> OK I'll merge this once we have that other code sorted out.
>
> Yes, this depends on Soren's patches.

Hi Beniamino,

sorry for the delay to merging S?ren's patches.

Can you rebase this patch on top of the pin control "devel" branch:
https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

Some stuff like structs and functions were renamed by me since it was
not generic enough.

Yours,
Linus Walleij
