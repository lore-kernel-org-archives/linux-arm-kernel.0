From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Jan 2013 11:46:30 +0100
Subject: [PATCH] usb: musb: ux500: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <20130110133818.GA22710@balto.lan>
References: <1357577261-31536-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdZD1i_tvDf6XFyk5muYjtDziQaMNGK6vvihhFJVztXUjw@mail.gmail.com>
 <20130110133818.GA22710@balto.lan>
Message-ID: <CACRpkdbmgQ0xDfkbgqc=zDqMDUK0O6uQOf3kX9v1+=+N5s42bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 2:38 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:
> On Thu, Jan 10, 2013 at 12:23:32PM +0100, Linus Walleij wrote:
>> On Mon, Jan 7, 2013 at 5:47 PM, Fabio Baltieri
>> <fabio.baltieri@linaro.org> wrote:
>>
>> > This patch converts the module to use clk_prepare_enable and
>> > clk_disable_unprepare variants as required by common clock framework.
>> >
>> > Without this the system crash during probe function.
>> >
>> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks for the ACK.  This bug was here unnoticed since 3.6 merge window,

Then it should have Cc: stable at kernel.org..

> do you think it may make sense to add this driver to u8500_defconfig?  I
> can send a patch if you say so...

Yes, can you make a patch updating the defconfig and also enabling
a few other things like charging maybe? Sync with Lee.

Yours,
Linus Walleij
