From: arend@broadcom.com (Arend van Spriel)
Date: Mon, 30 Jun 2014 10:15:54 +0200
Subject: [PATCH v4 0/4] brcmfmac: OOB interrupt support
In-Reply-To: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
References: <1404051421-24377-1-git-send-email-hdegoede@redhat.com>
Message-ID: <53B11CBA.3010501@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-14 16:16, Hans de Goede wrote:
> Hi All,
> 
> Here is v2 of the brcmfmac: OOB interrupt support series.

I guess this could use an update :-p

Regards,
Arend

> Changes since v1:
> -Post as a stand alone series, rather then together with sunxi pinctrl changes,
>  etc.
> -Add a patch to fixup the names of the register addresses used in the
>  "brcmfmac: Fix OOB interrupt not working for BCM43362" patch
> -Use the new register names in:
>  "brcmfmac: Fix OOB interrupt not working for BCM43362"
> 
> Changes since v2:
> -"dt: bindings: add bindings for Broadcom bcm43xx sdio devices"
>  * changed the compatible string to brcm,bcm4329-fmac
>  * replaced the dt-bindings example with a real world example
> -"brcmfmac: Fix OOB interrupt not working for BCM43362"
>  * updated commit message with confirmation from broadcom that this is the
>    right thing to do
> 
> Regards,
> 
> Hans
> 
