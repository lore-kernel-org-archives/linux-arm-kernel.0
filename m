From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Jun 2013 08:44:01 +0200
Subject: [PATCH] arm: kirkwood: sheevaplug: move pinmux configs to the
 right devices
In-Reply-To: <1370381552-9498-1-git-send-email-gmbnomis@gmail.com>
References: <1370381552-9498-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <20130605084401.49b30654@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Baatz,

On Tue,  4 Jun 2013 23:32:32 +0200, Simon Baatz wrote:
> When the pinmux mechanism was added in Kirkwood, the device driver
> core was not yet providing the possibility of attaching pinmux
> configurations to all devices, drivers had to do it explicitly, and
> not all drivers were doing this.
> 
> Now that the driver core does that in a generic way, it makes sense to
> attach the pinmux configuration to their corresponding devices.
> 
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
