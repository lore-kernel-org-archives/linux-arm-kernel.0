From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 26 Jan 2016 10:34:40 +0800
Subject: [PATCH v6 0/1] Introduce Innosilicon HDMI driver on Rockchip
 platforms
In-Reply-To: <30308769.0Ysu5UYYQv@diego>
References: <1453686197-20975-1-git-send-email-ykk@rock-chips.com>
 <30308769.0Ysu5UYYQv@diego>
Message-ID: <56A6DB40.9030209@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 01/25/2016 08:47 PM, Heiko St?bner wrote:
> Am Montag, 25. Januar 2016, 09:43:17 schrieb Yakir Yang:
>> Here are a brief introduction to Innosilicon HDMI IP:
>>    - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
>>    - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
>>    - Digital video interface supports a pixel size of 24, 30, 36, 48bits
>> color depth in RGB - S/PDIF output supports PCM, Dolby Digital, DTS digital
>> audio transmission (32-192kHz Fs) using IEC60958 and IEC 61937
>>    - The EDID and CEC function are also supported by Innosilicon HDMI
>> Transmitter Controlle
> have you lost separate the devicetree-binding patch somewhere?
>
> I don't remember it getting applied and Mark may miss it if it's only
> contained in some old series.

Ops, I may misunderstand the rule, I thought if patch was acked by 
maintainer, then I should keep it no changed. Hmmm, so not Acked but 
Applied, thanks, I would update now.

Yakir
>
> Heiko
>
>
>
