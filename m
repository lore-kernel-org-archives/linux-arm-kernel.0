From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 28 Apr 2017 11:06:38 +0200
Subject: [PATCH] pwm: sun4i: switch to atomic PWM
In-Reply-To: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
References: <20170427220002.20266-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170428090638.tkarvtkjh2pukjvo@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 28, 2017 at 12:00:02AM +0200, Alexandre Belloni wrote:
> Switch the driver to atomic PWM. This makes it easier to wait a proper
> amount of time when changing the duty cycle before disabling the channel
> (main use case is switching the duty cycle to 0 before disabling).
> 
> Also, the hardware read out is now greatly improved as it was formerly only
> handling PWM polarity.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

You have a bunch of checkpatch warnings, please fix them.

Once done, you have my reviewed-by.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170428/18862221/attachment.sig>
