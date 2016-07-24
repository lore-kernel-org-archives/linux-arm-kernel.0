From: hotran@apm.com (Hoan Tran)
Date: Sat, 23 Jul 2016 22:53:59 -0700
Subject: hwmon: xgene: Add support for X-Gene hwmon driver
In-Reply-To: <71a96a29-78e3-f251-dd8f-583031461678@riken.jp>
References: <02814a96-c620-c4af-e278-40432f6f701f@riken.jp>
 <9D204F6B-7C99-4543-87BF-4D9FC3F6475C@apm.com>
 <71a96a29-78e3-f251-dd8f-583031461678@riken.jp>
Message-ID: <CAFHUOYxXgaPDeCtOarD2qDDNOYYeH5WNUX22+0zRbd14XodfqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Itaru,

On Sat, Jul 23, 2016 at 10:04 PM, Itaru Kitayama
<itaru.kitayama@riken.jp> wrote:
> Hi Hoan,
>
> I didn't mention in my previous post, though I think I'm using fairly recent
> version of Tianocore F/W, and I can confirm there's the PCCT table,
>
> [    0.000000] ACPI: PCCT 0x00000047FA826000 000300 (v01 APM    XGENE
> 00000003      01000013)
>
> is this still not enough? If that's the case, I'll talk to APM for
> their latest development Tianocore version.

Your version is missing the "pcc-channel" property of hwmon inside
ACPI Table. You need a newer version of Tianocore.

> Also, if you or your folks can fold your patch set into APM's xgene-next
> GitHub repo, that would help me to keep up with the development.

xgene-next is currently used for device tree patch only.

Thanks
Hoan

>
> Itaru
>
>
> On 7/24/16 12:00 PM, Hoan Tran wrote:
>>
>> You need the new firmware and BIOS which support ACPI PCC mailbox.
>>
>> Thanks
>> Hoan
