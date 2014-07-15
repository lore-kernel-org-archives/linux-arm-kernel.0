From: afenkart@gmail.com (Andreas Fenkart)
Date: Tue, 15 Jul 2014 15:25:17 +0200
Subject: mwifiex card reset
In-Reply-To: <CAD=FV=Xi5B2=tssgQSgjeKtYVcw-x9pS6Ci580M6OfroPCb+RA@mail.gmail.com>
References: <CALtMJEBWPM+75wxM2Mp5EX_o6NWtZUJdYRCv6psbvdUn4k295w@mail.gmail.com>
 <20140628052220.GG10407@us.netrek.org>
 <20140628072322.GC7410@atomide.com>
 <CALtMJED5vfgkAhMBXKaDP6u9U9n41c-wziyTxt6e_7XTSxG3oQ@mail.gmail.com>
 <20140630061912.GA2461@atomide.com> <53B1BAC1.3090902@zonque.org>
 <477F20668A386D41ADCC57781B1F70430FE5F37540@SC-VEXCH1.marvell.com>
 <20140701065721.GM24891@us.netrek.org>
 <CA+NduCAuRFTQneJUBiKP2Aeq2HCxe71yxg_iDDStkNvhzRg-Rg@mail.gmail.com>
 <CAD=FV=Xi5B2=tssgQSgjeKtYVcw-x9pS6Ci580M6OfroPCb+RA@mail.gmail.com>
Message-ID: <CALtMJEBWVgxbc+Kqna41EBSc8Rwn=jFO-3BNjNWibvp6EQvAUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-01 17:09 GMT+02:00 Doug Anderson <dianders@chromium.org>:
> +Olof who posted the patch that Yuvaraj referenced.
>
> On Tue, Jul 1, 2014 at 5:20 AM, Yuvaraj Cd <yuvaraj.lkml@gmail.com> wrote:
>> On Tue, Jul 1, 2014 at 12:27 PM, James Cameron <quozl@laptop.org> wrote:
>>> On Mon, Jun 30, 2014 at 11:44:29PM -0700, Bing Zhao wrote:
>>>> I may have missed something, but doesn't the MMC_POWER_OFF and
>>>> MMC_POWER_ON|UP handling in controller driver help?
>>>> Anyway the clocks/GPIOs/regulators are sort of platform
>>>> dependent. Would it be better putting it in /arch/arm/mach-xxxxx/?
>>>
>>> Wouldn't device tree for mmc be better?
>> I have come across same problem.Below is the thread in which more
>> discussions happened on this.
>>  http://patchwork.ozlabs.org/patch/312444/
>> I am adding few more those who are interested in this solution.
>
> Thanks to Yuvaraj for referencing the old thread.

http://www.spinics.net/lists/linux-mmc/msg26564.html

Quite a read indeed

Meanwhile I got a working prototype for omap_hsmmc/mwifiex based on this series:
http://www.spinics.net/lists/linux-mmc/msg27228.html

I will post my patches, once the FDT format is set in stone, and Ulf
has had some time to work on v2 of his series.
