From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2016 14:12:23 -0800
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <5275588.dlJdb2OzJi@wuerfel>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <20161206011244.GC2749@dragon> <20161207203412.GA10158@localhost>
 <5275588.dlJdb2OzJi@wuerfel>
Message-ID: <CAOesGMh5=R18+wfM5WjUPnQ2a7UFi35t11cRDyTwCYHxpySnMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 7, 2016 at 1:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, December 7, 2016 12:34:12 PM CET Olof Johansson wrote:
>>
>> So, it seems that Arnd didn't apply the old patch to fixes-non-critical, or
>> at least didn't push out after doing it. So, I've done that now, as well as
>> applied the fixup you have above.
>>
>
> My mistake, I forgot to push it out.

No worries.

> I checked the other branches now and found two other commits missing
> in next/fixes-non-critical:
>
>
> arm64: tegra: Add missing Smaug revision
> arm64: tegra: Add VDD_GPU regulator to Jetson TX1
>
> Both sent by Thierry Reding last Friday. I can add them back on top
> or you pick them up again if you are already busy doing merges.
>
> For the first patch, I had amended the changelog text, this is the
> version I had.

I'm done touching the tree for today so you can rebase and push your
versions if you want -- probably easiest all around.


-Olof
