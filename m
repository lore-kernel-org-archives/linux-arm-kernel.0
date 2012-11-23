From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 23 Nov 2012 16:43:18 +0100
Subject: [PATCH 0/2] clk: ux500: Add abx500 clock driver
In-Reply-To: <CACRpkdZnrCdp=c+Ln2mNaxpnwg5HRgdcDz4U2wX=ToTG8sUYJg@mail.gmail.com>
References: <1353580540-3774-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZnrCdp=c+Ln2mNaxpnwg5HRgdcDz4U2wX=ToTG8sUYJg@mail.gmail.com>
Message-ID: <CAPDyKFqojnJ1d3qtJA8=EooD06+5qDLaHM67gdMW4w3x1q0+qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2012 14:25, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Nov 22, 2012 at 11:35 AM, Ulf Hansson
> <ulf.hansson@stericsson.com> wrote:
>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> The abx500 clocks will not be initialized from the normal clk init call.
>>
>> Instead the abx500 clocks relies on the abx500-core and therfore it also
>> make sense to let it be a child device to it.
>>
>> Right now, I am not sure of which tree to go through when merging this, but
>> until that is settled I hope to collect ACKs.
>>
>> Upcoming series will add the abx500 clock implementations and definitions.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> for all.
>
> I think the best is to have Sam ACK it and take this through
> Mr. Turquette's tree?
>
> Yours,
> Linus Walleij

Samuel already applied the mfd patch.

So let's take these patches as standalone patches. Mike can take the
clk patch through his tree, that should not be any problem I think.

Kind regards
Ulf Hansson
