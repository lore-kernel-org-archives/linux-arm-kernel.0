From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Wed, 14 Sep 2016 18:28:39 +0000
Subject: [PATCH v1 2/3] ARM: dts: imx6q-apalis-ixora: Remove use of
 pwm-leds
In-Reply-To: <5eee36b0a60c41a05ca2a161b8ef3eb7@agner.ch>
References: <9d2c17aa2e00e6ff4349a53de8247860d2382607.1473833908.git.maitysanchayan@gmail.com>
 <6111feb57b5fbaa29eeb6ba089bb2824bbf2f8ff.1473833908.git.maitysanchayan@gmail.com>
 <5eee36b0a60c41a05ca2a161b8ef3eb7@agner.ch>
Message-ID: <1473877718.20131.0.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-14 at 08:58 -0700, Stefan Agner wrote:
> On 2016-09-13 23:35, Sanchayan Maity wrote:
> > 
> > Remove use of pwm-leds and use the standard /sys/class/pwm
> > interface from PWM subsystem.
> Don't we have actual leds on the Ixora?

Yes, sure, but not really PWM ones:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/ar
ch/arm/boot/dts/imx6q-apalis-ixora.dts?id=refs/tags/v4.8-rc6#n124
