From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 14 May 2014 14:03:14 +0200
Subject: [PATCH v13 2/2] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <5370C5D1.2070901@broadcom.com>
References: <1399896288-5826-1-git-send-email-hdegoede@redhat.com>
 <1399896288-5826-3-git-send-email-hdegoede@redhat.com>
 <5370C5D1.2070901@broadcom.com>
Message-ID: <CAPDyKFrq=v1SU0+rC5_tCJ1D5jUOd3vwLXpxgpzB9X5NQd-deg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 15:00, Arend van Spriel <arend@broadcom.com> wrote:
> On 05/12/2014 02:04 PM, Hans de Goede wrote:
>>
>> From: David Lanzend?rfer<david.lanzendoerfer@o2s.ch>
>>
>> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
>> designware idmac controller, which is identical to the one found in the
>> mmc-dw
>> hosts. However the rest of the host is not identical to mmc-dw, it deals
>> with
>> sending stop commands in hardware which makes it significantly different
>> from the mmc-dw devices.
>>
>> HdG: Various cleanups and fixes.
>
>
> Just nitpicking, but usually the above line should be added below the
> original signoff, so:
>
>> Signed-off-by: David Lanzend?rfer<david.lanzendoerfer@o2s.ch>
>
> [hdegoede at redhat.com: various cleanups and fixes]
>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>
>
> As is documented in SubmittingPatches.
>
> Gr. AvS


This looks good to me, thanks Hans!

I will include this in the next PR I send to Chris, I will also take
the liberty to fixup the commit msg as pointed out by Arend.

Kind regards
Ulf Hansson
