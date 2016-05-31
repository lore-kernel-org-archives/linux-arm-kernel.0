From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 31 May 2016 19:09:57 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <574CA1ED.8050007@web.de>
References: <20160530123013.11575-1-luoyi.ly@gmail.com>
 <20160530194340.GE4908@lukather> <574CA1ED.8050007@web.de>
Message-ID: <20160531170957.GM4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2016 at 10:26:21PM +0200, Bernhard Nortmann wrote:
> Am 30.05.2016 um 21:43 schrieb Maxime Ripard:
> >Hi,
> >
> >On Mon, May 30, 2016 at 08:30:13PM +0800, luoyi.ly at gmail.com wrote:
> >>From: luoyi <luoyi.ly@gmail.com>
> >>
> >>Add support for the Bananapi M1 Plus A20 development board from sinovoip.com.cn .
> >>This board features 1G RAM, 2 USB A receptacles, 1 micro USB receptacle for
> >>OTG, 1 micro USB receptacle for power, HDMI, sata, Gbit ethernet, ir receiver,
> >>3.5 mm jack for stero sound out, on board microphone, 40 gpio pins and sdio wifi.
> >What is the difference between the M1+ and the M1?
> 
> The M1+ is an updated version of the original Banana Pi. If you're
> interested in the details, have a look at
> http://linux-sunxi.org/Banana_Pi#Variants .  "BPi-M1+" is SinoVoip's
> counterpart of LeMaker's "Banana Pro", for which a .dts already
> exists. Judging from .fex files, only a single pin assignment seems
> to differ between the two (audio_pa_ctrl, PH26 vs. PH15).

Gee, that's confusing :)

I guess we should just include the banana pro DTB and change that pin
(and the i2s pins Luo was mentionning).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160531/eba0f737/attachment.sig>
