From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 02 Feb 2016 22:37:52 +0100
Subject: [PATCH v8 0/2] Add Rockchip Inno-HDMI driver
In-Reply-To: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
References: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
Message-ID: <33063104.hTo1MPWOYh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Am Freitag, 29. Januar 2016, 14:42:48 schrieb Yakir Yang:
> Here are a brief introduction to Innosilicon HDMI IP:
>   - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
>   - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
>   - Digital video interface supports a pixel size of 24, 30, 36, 48bits
> color depth in RGB - S/PDIF output supports PCM, Dolby Digital, DTS digital
> audio transmission (32-192kHz Fs) using IEC60958 and IEC 61937
>   - The EDID and CEC function are also supported by Innosilicon HDMI
> Transmitter Controlle

do you plan on picking up this two patches soon? It seems there were no 
further objections.

Caesar submitted the dts parts but I need to hold off on them until you took 
the driver part :-) .


Thanks
Heiko
