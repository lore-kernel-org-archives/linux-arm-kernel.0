From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 25 Jan 2016 13:47:06 +0100
Subject: [PATCH v6 0/1] Introduce Innosilicon HDMI driver on Rockchip
 platforms
In-Reply-To: <1453686197-20975-1-git-send-email-ykk@rock-chips.com>
References: <1453686197-20975-1-git-send-email-ykk@rock-chips.com>
Message-ID: <30308769.0Ysu5UYYQv@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 25. Januar 2016, 09:43:17 schrieb Yakir Yang:
> Here are a brief introduction to Innosilicon HDMI IP:
>   - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
>   - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
>   - Digital video interface supports a pixel size of 24, 30, 36, 48bits
> color depth in RGB - S/PDIF output supports PCM, Dolby Digital, DTS digital
> audio transmission (32-192kHz Fs) using IEC60958 and IEC 61937
>   - The EDID and CEC function are also supported by Innosilicon HDMI
> Transmitter Controlle

have you lost separate the devicetree-binding patch somewhere?

I don't remember it getting applied and Mark may miss it if it's only 
contained in some old series.


Heiko
