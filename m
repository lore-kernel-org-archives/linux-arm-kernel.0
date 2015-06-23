From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 23 Jun 2015 11:07:59 +0800
Subject: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <20150622101038.GV7557@n2100.arm.linux.org.uk>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
 <1434967564.31094.20.camel@x220>
 <20150622101038.GV7557@n2100.arm.linux.org.uk>
Message-ID: <5588CD8F.2040600@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

? 2015/6/22 18:10, Russell King - ARM Linux ??:
> On Mon, Jun 22, 2015 at 12:06:04PM +0200, Paul Bolle wrote:
>> But I think there's no platform_device with a "dw-hdmi-i2s-audio" name.
>> So I wonder whether this MODULE_ALIAS() is actually needed. What breaks
>> if you leave it out?
> +       } else if (hdmi_readb(hdmi, HDMI_CONFIG0_ID) & HDMI_CONFIG0_I2S) {
> +               pdevinfo.name = "dw-hdmi-ahb-audio";
>
> This should be "dw-hdmi-i2s-audio" to avoid picking up on my AHB audio
> driver.
Yep, thanks a lot ;)

- Yakir
