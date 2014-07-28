From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 28 Jul 2014 18:17:53 +0200
Subject: [PATCH v2 00/11] ARM: dts: zynq: Prepare Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <53D677B1.2000700@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars-Peter,

Am 25.07.2014 01:00, schrieb Andreas F?rber:
> most notably I'm missing 
> ADI ADV7513 and AXI-HDMI support
[...]
> Cc: Lars-Peter Clausen <lars@metafoo.de> (HDMI)

Could you please enlighten us what the status of upstreaming
ADV7511/ADV7513 support is? It is declared "work in progress" here:

http://wiki.analog.com/resources/tools-software/linux-drivers/drm/adv7511

I see some adv7511 V4L bits in drivers/media/i2c/adv7511.c, but no
drivers/gpu/drm/i2c/adv7511_{core,audio}.c as on the xcomm_zynq branch,
nor any devicetree documentation. Patchwork doesn't show any recent
submissions to LKML.

Is any major rework needed for you to get the 3.14.12 based driver upstream?

AXI SPDIF I found in 3.16, as you noticed; what about AXI HDMI? [*]
Is there any work ongoing to get that upstream as well?

Any pointers appreciated.

Thanks,
Andreas

[*]
http://wiki.analog.com/resources/tools-software/linux-drivers/platforms/zynq

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
