From: dhdang@apm.com (Duc Dang)
Date: Wed, 14 Sep 2016 18:57:59 -0700
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 -
 part1
In-Reply-To: <6041122.z65jfDXEcc@wuerfel>
References: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
 <6041122.z65jfDXEcc@wuerfel>
Message-ID: <CADaLNDmMEWEd4o-tf4Kcqy7PP-abBg=Q1-Qdvv5CoDdoLEvi=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday, September 2, 2016 11:46:31 AM CEST Duc Dang wrote:
>> Hi Arnd, Olof,
>>
>> This is the first part of DTS changes for X-Gene platforms targeted for 4.9.
>>
>> The changes include:
>> + X-Gene Soc PMU support patch set from Tai Nguyen (v10 reviewed by
>> Mark, DT binding document acked by Rob [1] and was suggested to merge
>> via am-soc tree by Will [2])
>> + Follow up patch to enable DT entry for SoC PMU on X-Gene v2
>> + Correct PCIe legacy interrupt mode to level-active high
>> + DTS entry for X-Gene hwmon (v4 acked by Guenter, DT binding document
>> and driver is in linux-next now [3])
>>
>> Regards,
>> Duc Dang.
>
> Sorry for the long delay, I've just now started looking at the dts changes
> for arm64. The changes to arch/arm64/boot/dts look fine, but I don't
> want to mix driver changes with dts changes, as we use separate
> branches for those.
>
> Please send this again as two pull requests, one for the dts changes, and
> one for the rest (pmu driver, binding and MAINTAINERS file). Please
> also include an explanation in the tag description about why this gets
> merged through arm-soc. I see that Will suggested doing it that way,
> but I don't see what the reason is. We normally don't touch that directory.
Hi Arnd,

I am not clear about the reason either. Probably we don't have a
dedicated tree for SoC PMU?

Hi Will,

Can you please comment?

Regards,
Duc Dang.
>
>         Arnd
>
>>
>> [1]: https://lkml.org/lkml/2016/7/15/563
>> [2]: https://lkml.org/lkml/2016/7/20/224
>> [3]: http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=893485e74c37669aeecf0b648dbfbd8e2f0471c3
>> ------
>>
>> The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:
>>
>>   Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)
>>
>> are available in the git repository at:
>>
>>   https://github.com/AppliedMicro/xgene-next.git tags/xgene-dts-for-v4.9-part1
>>
>> for you to fetch changes up to 1c983fc9369420748192712bde2429af3e580390:
>>
>>   arm64: dts: apm: Add X-Gene SoC hwmon to device tree (2016-09-02
>> 10:43:41 -0700)
>>
>> ----------------------------------------------------------------
>> X-Gene DTS changes queued for v4.9 - part 1
>>
>> This patch set includes:
>> + X-Gene v1 SoC Performance Monitoring Unit (PMU) support
>> + DTS entry to enable SoC PMU for X-Gene v2 SoC
>> + PCIe legacy interrupt polarity fix for X-Gene
>> + X-Gene SoC hwmon DTS entry
>>
>
>
