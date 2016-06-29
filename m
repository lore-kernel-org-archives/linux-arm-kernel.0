From: kvalo@codeaurora.org (Kalle Valo)
Date: Wed, 29 Jun 2016 20:01:13 +0300
Subject: [PATCH 2/4] ARM: dts: sun7i-a20-cubietruck: Set brcm,
 nvram_file_name
In-Reply-To: <1467209074-15634-2-git-send-email-hdegoede@redhat.com> (Hans de
 Goede's message of "Wed, 29 Jun 2016 16:04:32 +0200")
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <1467209074-15634-2-git-send-email-hdegoede@redhat.com>
Message-ID: <87wpl8c4km.fsf@purkki.adurom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hans de Goede <hdegoede@redhat.com> writes:

> The cubietruck uses an ap6210 sdio wifi module, set brcm,nvram_file_name
> to brcmfmac43362-ap6210.txt so that we can ship the ap6210 specific
> nvram file in linunx-firmware to get the wifi to work out of the box
> without users needing to download and install the nvram file themselves.
>
> Note a downside of this patch is that users who have already manually
> installed the nvram file will need to rename it.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 1 +
>  1 file changed, 1 insertion(+)

I can't apply .dts changes so better to send them in a separate
patchset.

-- 
Kalle Valo
