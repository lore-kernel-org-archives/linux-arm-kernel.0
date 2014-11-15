From: mw@semihalf.com (Marcin Wojtas)
Date: Sat, 15 Nov 2014 09:25:58 +0100
Subject: [PATCH v2] ARM: mvebu: re-enable SDHCI driver for Armada 38x SoC
 in v7 defconfig
In-Reply-To: <CAPv3WKe4bL3cMO7xnLktG5KT5X4B+NsA22=fj-10i8QuLedTFg@mail.gmail.com>
References: <1415978967-7350-1-git-send-email-mw@semihalf.com>
 <20141115024819.GM3698@titan.lakedaemon.net>
 <CAPv3WKe4bL3cMO7xnLktG5KT5X4B+NsA22=fj-10i8QuLedTFg@mail.gmail.com>
Message-ID: <CAPv3WKe=PQ6=NUiz3u=xPyDN_VJq=E8B5-a0_reMn4Gj85WdsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Re-send my answer to the list - no UTF-8 on my mobile...

2014-11-15 7:55 GMT+01:00 Marcin Wojtas <mw@semihalf.com>:
> Hi Jason,
>
> Thanks- this was actually no CC on purpose. I had huge (and pretty strange)
> problems with being dropped by LAKML and this was test after re-configuring
> my server. The full patchset of 5 commits is prefixed 'PATCH v3', contains
> all necessary CC's and was accepted by the list yesterday, so you can take a
> look on all of them now.
>
> Best regards,
> Marcin
>
> 15-11-2014 03:48, "Jason Cooper" <jason@lakedaemon.net> napisa?(a):
>
>> Marcin,
>>
>> On Fri, Nov 14, 2014 at 04:29:27PM +0100, Marcin Wojtas wrote:
>> > In the recent update of mvebu_v7_defconfig a config that enables
>> > sdhci-pxav3
>> > driver, that supports SDHCI interface of Armada 38x SoC, disappeared.
>> >
>> > This commit enables CONFIG_MMC_SDHCI_PXAV3 back.
>> >
>> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> > Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> > Fixes fc9fa8714a75 ("ARM: mvebu: update v7 defconfig with useful
>> > options")
>>
>> Please don't forget to Cc the maintainers.  ;-)  No need to resend, I
>> have it queued up.
>>
>> thx,
>>
>> Jason.
