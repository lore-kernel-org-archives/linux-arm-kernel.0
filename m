From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 20:01:02 +0200
Subject: [linux-sunxi] Re: [PATCH 2/4] ARM: dts: sun7i-a20-cubietruck: Set
 brcm,nvram_file_name
In-Reply-To: <87wpl8c4km.fsf@purkki.adurom.net>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <1467209074-15634-2-git-send-email-hdegoede@redhat.com>
 <87wpl8c4km.fsf@purkki.adurom.net>
Message-ID: <e0355531-d727-ea7f-0930-22b47c568a5a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On 29-06-16 19:01, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>
>> The cubietruck uses an ap6210 sdio wifi module, set brcm,nvram_file_name
>> to brcmfmac43362-ap6210.txt so that we can ship the ap6210 specific
>> nvram file in linunx-firmware to get the wifi to work out of the box
>> without users needing to download and install the nvram file themselves.
>>
>> Note a downside of this patch is that users who have already manually
>> installed the nvram file will need to rename it.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 1 +
>>  1 file changed, 1 insertion(+)
>
> I can't apply .dts changes so better to send them in a separate
> patchset.

Maxime Ripard who is in the Cc maintains the dts files
in question, I've send these as one set because I find
that sending out actual dts usage examples helps.

Regards,

Hans
