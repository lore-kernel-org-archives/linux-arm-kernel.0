From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 15 Dec 2014 16:48:08 +0100
Subject: [RFC PATCH 0/6] Those patches is used for dw_hdmi audio.
In-Reply-To: <20141215120013.GH11285@n2100.arm.linux.org.uk>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <20141215103830.GD11285@n2100.arm.linux.org.uk>
 <548EC9E1.5040206@rock-chips.com> <548ECB66.70004@rock-chips.com>
 <20141215120013.GH11285@n2100.arm.linux.org.uk>
Message-ID: <20141215164808.092cc7ac@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Dec 2014 12:00:13 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> I really don't want to end up in another cocked up situation like
> what happened with the Dove audio, where it became politically
> impossible for the SolidRun platform to be properly supported by
> mainline kernels.

Hi Russell,

I don't see what you mean. The last patches I proposed for the TDA998x
and the HDMI CODEC do exactly what you wanted: S/PDIF out from the
kirkwood audio device towards both S/PDIF optical and HDMI output2 by
default.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
