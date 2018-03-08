From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 8 Mar 2018 16:14:44 +0100
Subject: [PATCH 2/6] ARM: dts: tegra: apalis-tk1: activate pwm pin muxing
 for pwm3
In-Reply-To: <20180210013806.28496-3-marcel@ziswiler.com>
References: <20180210013806.28496-1-marcel@ziswiler.com>
 <20180210013806.28496-3-marcel@ziswiler.com>
Message-ID: <20180308151444.GD13814@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 10, 2018 at 02:38:02AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Activate PWM pin muxing for Apalis PWM3. Note that the same PWM3 is
> already active on pu6 being Apalis BKL1_PWM as well. Therefore exporting
> that one for raw sysfs access will fail and one has to revert to using
> the pwm backlight.
> 
> Downstream commit 668ddb921800 ("apalis-tk1: activate pwm pin muxing for
> pwm3").

That line is rather meaningless without knowing what exactly
"downstream" is. I've removed that line.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/08cab0eb/attachment.sig>
