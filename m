From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 21 Dec 2015 15:25:58 +0800
Subject: [RFC PATCH v1 0/2] Introduce Innosilicon HDMI driver on Rockchip
 platforms
In-Reply-To: <1447227952-4787-1-git-send-email-ykk@rock-chips.com>
References: <1447227952-4787-1-git-send-email-ykk@rock-chips.com>
Message-ID: <5677A986.10103@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir
     I want to convert drm/rockchip to support atomic api,
     I'd like you can do some modify to adapt it.

- Mark

On 2015?11?11? 15:45, Yakir Yang wrote:
> Hi guys:
>
> Here are a brief introduction to Innosilicon HDMI IP:
>   - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
>   - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
>   - Digital video interface supports a pixel size of 24, 30, 36, 48bits color
>     depth in RGB
>   - S/PDIF output supports PCM, Dolby Digital, DTS digital audio transmission
>     (32-192kHz Fs) using IEC60958 and IEC 61937
>   - The EDID and CEC function are also supported by Innosilicon HDMI Transmitter
>     Controlle
>
> This IP have been integrated on some Rockchip CPUs (like RK3036/RK312x), due
> to those CPUs haven't been landed on manline kernel, so I creat a branch to
> verify this series [https://github.com/rockchip-linux/kernel].
>
> - Yakir
>
>
> Yakir Yang (2):
>    drm: rockchip/hdmi: add Innosilicon HDMI support
>    dt-bindings: add document for Innosilicon HDMI on Rockchip platform
>
>   .../display/rockchip/inno_hdmi-rockchip.txt        |   50 +
>   drivers/gpu/drm/rockchip/Kconfig                   |    8 +
>   drivers/gpu/drm/rockchip/Makefile                  |    1 +
>   drivers/gpu/drm/rockchip/inno_hdmi.c               | 1008 ++++++++++++++++++++
>   drivers/gpu/drm/rockchip/inno_hdmi.h               |  364 +++++++
>   5 files changed, 1431 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>   create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>   create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.h
>


-- 
?ark Yao
