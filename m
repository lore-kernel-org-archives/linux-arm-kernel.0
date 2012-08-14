From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 15:40:30 -0400
Subject: [patch] ARM: Kirkwood: Fix iconnect leds
In-Reply-To: <20120805203610.540496769@rtp-net.org>
References: <20120805203610.540496769@rtp-net.org>
Message-ID: <20120814194030.GT22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 10:35:56PM +0200, Arnaud Patard wrote:
> While converting, a led has been missed leading to wrong power blue led
> definition. Add it back and fix the gpio used on the power blue led.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

added Acked-By: from Andrew Lunn and applied to:

git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

thx,

Jason.
