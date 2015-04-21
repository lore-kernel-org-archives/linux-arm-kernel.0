From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 21 Apr 2015 15:18:50 +0200
Subject: Fwd: [PATCH] usb-otg: atmel-usba-udc: initialize usb_prev to the
 actual value
In-Reply-To: <CA+XxOSFO1zYKJLaAQ6qixReUaViizOPve445B1rrKE+Om2xRPQ@mail.gmail.com>
References: <CA+XxOSExCVBd0TFuY+wmjL-pxhp148H1FpnQLBtV0q2R5OwHzg@mail.gmail.com>
 <CA+XxOSFO1zYKJLaAQ6qixReUaViizOPve445B1rrKE+Om2xRPQ@mail.gmail.com>
Message-ID: <20150421131850.GA11427@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Helle Lo?c,

On Tue, Apr 21, 2015 at 02:52:35PM +0200, lo?c tourlonias wrote:
> During start of the usb gadget device, usb_prev must be initialize to
> the actual value of vbus_pin to avoid missing the first usb host
> detection.

You are a bit too late, it is already fixed[1].

Sylvain

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=227ab58cff3c26ec279598112887d6bcca677a0c
