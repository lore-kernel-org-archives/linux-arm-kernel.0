From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 6 May 2015 14:16:08 -0300
Subject: [PATCH] ARM: dts: cubox-i: add support for Broadcom
 Wifi/Bluetooth devices
In-Reply-To: <20150506155416.GX2067@n2100.arm.linux.org.uk>
References: <1430923179-25448-1-git-send-email-festevam@gmail.com>
 <20150506155416.GX2067@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DMMQ3wJ+0FFJHW=LekLPypXzfEcFEBaKRcj9CmmWpkVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 6, 2015 at 12:54 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> You should also mention that it's a bodge because you're permanently
> enabling the regulators rather than controlling them from the mmc-pwrseq
> stuff.
>
> I would like to see a proper implementation rather than a bodge -
> especially one which permanently enables the oscillator regulator,
> thus having the oscillator output trying to drive a device which is
> powered down, which will forward-bias the ESD diodes... which is not
> a particularly nice thing to do.
>
> So really that's a NAK on this.  Please do the job properly.

Good point. I have prepared a v2 with the proper bindings now.

Regards,

Fabio Estevam
