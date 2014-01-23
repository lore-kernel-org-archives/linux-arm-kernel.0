From: john.tobias.ph@gmail.com (John Tobias)
Date: Wed, 22 Jan 2014 19:25:42 -0800
Subject: Internal error: Oops: 17 [#1] ARM
In-Reply-To: <CAOMZO5BhZspH3FfDh+3z0xBpgxWEHK1Fa5KOYsN5og2VfGktXQ@mail.gmail.com>
References: <CACUGKYPXficVuqDgy6_Tnh9b-VOXDNK=+nqb6U5O6NpcZOGGpQ@mail.gmail.com>
 <20140122164100.GE15937@n2100.arm.linux.org.uk>
 <CACUGKYPakuAGOWb+RetqNhEBvRP-+Pmtu2_4a2zuV0bFR0QJRA@mail.gmail.com>
 <CAOMZO5BhZspH3FfDh+3z0xBpgxWEHK1Fa5KOYsN5og2VfGktXQ@mail.gmail.com>
Message-ID: <CACUGKYMwFVKqQAVoXkE8vgzYXQXnZYtsYeHEDY20XiqcT-Drnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Attached are the two patch files that I applied in the 3.13 released
so that the kernel will detect my eMMC in DDR50.
(let me correct my previous email, I was mentioning SDR50 but it
should be DDR50).
eMMC info:

clock:          52000000 Hz
actual clock:   49500000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    1 (mmc high-speed)
signal voltage: 0 (3.30 V)

I reboot my device often and it shows during the reboot.

Regards,

john




On Wed, Jan 22, 2014 at 6:28 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Jan 22, 2014 at 9:49 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hello all,
>>
>> Just to confirm that the error I posted previously exist in 3.13
>> released. Just be noted that some patches related to eMMC/sdhci has
>> been applied in order to boot the 3.13 on my board.
>> Addition to that, I was getting additional errors (please see below):
>> - It happened during the reboot.
>>
>> Cc'ng Dong Aisheng.
>
> What are the steps to reproduce this? Which SoC are you using?
>
> Regards,
>
> Fabio Estevam
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sdhci-esdhc-imx.patch
Type: application/octet-stream
Size: 2464 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/15d70bc1/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sdhci.patch
Type: application/octet-stream
Size: 2522 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140122/15d70bc1/attachment-0001.obj>
