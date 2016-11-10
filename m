From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 10 Nov 2016 11:59:00 +0100
Subject: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
In-Reply-To: <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1626072.dpWPnWgGl9@wuerfel>
 <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
 <6723536.97ljqcB8tS@wuerfel>
 <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
Message-ID: <CAPDyKFrD1wvOMvjvST15SREKK42dkyeJphaAZbeRJ9xAaj-Xeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 November 2016 at 10:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Wed, Nov 9, 2016 at 10:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday, November 9, 2016 6:19:06 PM CET Geert Uytterhoeven wrote:
>>> On Wed, Nov 9, 2016 at 5:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> > On Wednesday, November 9, 2016 2:34:33 PM CET Geert Uytterhoeven wrote:
>>> >> > And Samsung.
>>> >> > Shall I create the immutable branch now?
>>> >>
>>> >> Arnd: are you happy with the new patches and changes?
>>> >
>>> > I still had some comments for patch 7, but that shouldn't stop
>>> > you from creating a branch for the first three so everyone can
>>> > build on top of that.
>>>
>>> Thanks!
>>>
>>> What about patch [4/7]?
>>> Haven't you received it? Your address was in the To-line for all 7 patches.
>>
>> Ok, I see it now, looks good. That should be included as well then.
>
> Thanks, I've created the branch/tag :
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
>     branch soc-device-match
>     signed tag soc-device-match-tag1
>
> In the mean time, Ulf has applied the first two patches to mmc/next, on top
> of lots of MMC work :-(

No worries! :-)

>
> Ulf, as this is not only a dependency for Freescale/NXP (for sdhci-of-esdhc),
> but also for Samsung and Renesas, would it still be possible to replace these
> two commits
>
>     8b82c17a8ae533d6 base: soc: introduce soc_device_match() interface
>     6fa350172b098f0f base: soc: Check for NULL SoC device attributes
>
> by a merge of soc-device-match-tag1?

Yes, I will take care of it during the day.

Kind regards
Uffe
