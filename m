From: olof@lixom.net (Olof Johansson)
Date: Mon, 7 Oct 2013 16:43:14 -0700
Subject: [PATCH] arm: socfpga: Fix incorrect sdmmc clock name
In-Reply-To: <20131007232857.7445.3041@quantum>
References: <1376322134-17408-1-git-send-email-dinguyen@altera.com>
 <20130814054810.GF16635@quad.lixom.net>
 <1376492274.8715.2.camel@linux-builds1>
 <20131007201254.7445.8105@quantum>
 <1381178249.1584.1.camel@linux-builds1>
 <20131007232857.7445.3041@quantum>
Message-ID: <CAOesGMjC7rOghacXUEp6bE=8pXWGMBZ-M637ZiLMKBp+-KUPug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 4:28 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Dinh Nguyen (2013-10-07 13:37:29)
>> Hi Mike,
>>
>> On Mon, 2013-10-07 at 13:12 -0700, Mike Turquette wrote:
>> > Quoting Dinh Nguyen (2013-08-14 07:57:54)
>> > > On Tue, 2013-08-13 at 22:48 -0700, Olof Johansson wrote:
>> > > > On Mon, Aug 12, 2013 at 10:42:14AM -0500, dinguyen at altera.com wrote:
>> > > > > From: Dinh Nguyen <dinguyen@altera.com>
>> > > > >
>> > > > > The SD/MMC clock is named "sdmmc_clk", and NOT "mmc_clk".
>> > > > >
>> > > > > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> > > > > Cc: Mike Turquette <mturquette@linaro.org>
>> > > > > CC: Arnd Bergmann <arnd@arndb.de>
>> > > > > CC: Olof Johansson <olof@lixom.net>
>> > > > > Cc: Pavel Machek <pavel@denx.de>
>> > > > > Cc: linux-arm-kernel at lists.infradead.org
>> > > >
>> > > > Hi Dinh,
>> > > >
>> > > > Do you want this applied in fixes for 3.11? If so, can you give me a oneliner
>> > > > on what the impact here is? mmc doesn't come up at all, or something more
>> > > > subtle?
>> > >
>> > > Hi Olof,
>> > >
>> > > No, this is go into 3.12 as I am still working on the bindings for
>> > > SD/MMC.
>> > >
>> > > The oneliner: "The SD/MMC driver was intermittently not coming up
>> > > because it was not able to get the correct clock."
>> >
>> > Olof, did you take this? If not I'll put it into my next batch of fixes
>> > for 3.12.
>>
>> No, Olof did not get a chance to pick this up for 3.12. I resent the
>> patch with the updated commit message for 3.13:
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/198824.html
>
> Thanks for the link. I've taken that version into clk-fixes for 3.12.


Thanks Mike, and sorry for dropping the ball Dinh. Next time feel free
to remind me if it happens. A week is the normal grace period. :)


-Olof
