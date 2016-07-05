From: dhdang@apm.com (Duc Dang)
Date: Tue, 5 Jul 2016 10:13:53 -0700
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.8 -
 part1
In-Reply-To: <20160705044612.GK1669@localhost>
References: <CADaLNDmLXF3Y7bcabHzzu5eXXqQ8R98QUgO8yKTnCcqCRXPnDg@mail.gmail.com>
 <20160705044612.GK1669@localhost>
Message-ID: <CADaLNDnnpMCK=_TeXSXzsartu7QTrtFYfwcMbLNBu16FsUy86w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2016 at 9:46 PM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Tue, Jun 21, 2016 at 04:40:49PM -0700, Duc Dang wrote:
>> Hi Arnd, Olof,
>>
>> This is the first part of DTS changes for X-Gene platforms targeted for 4.8
>>
>> The changes includes
>> + 2 clean-up and style fix from Bjorn with Rob's ACK [1]
>> + A timer interrupt polarity fix for X-Gene 2 (refer to Marc's
>> arm/arm64 arch timer fix [2])
>
> I'd recommend considering switching to symbolic flag definitions, to make it
> easier for others to interpret the DT (and for downstream users to change
> where needed). Anyway, not a high-priority thing, just something to keep in
> mind for some time in the future.

Thanks, Olof.

I will keep this in mind for future clean-up.

>
>> + Clean up an unused clk node (qmlclk) for X-Gene 1
>>
>> Marc's arch timer series [2] has a change in apm-storm.dtsi file. I
>> verified and the order of applying Marc's apm-storm.dtsi change and
>> the DT changes in xgene-next did not cause any conflict.
>>
>> [1]: (https://lkml.org/lkml/2016/6/14/340
>> [2]: http://www.spinics.net/lists/linux-samsung-soc/msg53533.html
>>
>> Regards,
>> Duc Dang.
>> ------
>>
>> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
>>
>>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.8-part1
>>
>> for you to fetch changes up to ddbc71d96012fbcc4b9e42fd1c131f185875f73f:
>>
>>   arm64: dts: apm: Remove unused qmlclk node on X-Gene 1 (2016-06-20
>> 18:41:49 -0700)
>
> Merged into next/dt64.
>
> Thanks!
>
> -Olof

Regards,
Duc Dang.
