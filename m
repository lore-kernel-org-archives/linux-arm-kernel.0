From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 7 Jul 2016 18:42:22 -0400
Subject: [PATCH 6/7] dt-bindings: net: bgmac: add bindings documentation
 for bgmac
In-Reply-To: <13160704.EGDxD1URaF@wuerfel>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
 <3327458.KVBg7y9SeP@wuerfel>
 <CAC3K-4qZ9tpEAuDBjL-bkjn5F2Xfr4CAmVGc=DpgVh8MrqEDtQ@mail.gmail.com>
 <13160704.EGDxD1URaF@wuerfel>
Message-ID: <CAC3K-4qnnbG2c8rQWhUx+ZTOvLKrKL+iZ3=WVZ1tuXCixHV3gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2016 at 3:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday, July 5, 2016 7:18:45 PM CEST Jon Mason wrote:
>> >
>> > Ok, then I'd suggest making the compatible string here
>> >
>> >         compatible = "brcm,nsp-amac", "brcm,amac";
>>
>> It is called GMAC in the NS and NSP documentation, but AMAC is fine
>> with me (as it is called this in the NS2 documentation).  I'll make
>> the necessary change and repush.
>
> Ok, then we can use
>
>         compatible = "brcm,nsp-gmac", "brcm,amac";
>
> to be consistent with that documentation and have the generic name as the
> fallback.

After looking at the docs again, I see the blocks being referred to as
"AXI MAC" (while the registers are being called GMAC).  To keep it
consistent, I'll just change everything to be "amac".

Thanks,
Jon

>
>         Arnd
