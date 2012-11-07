From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 7 Nov 2012 08:09:52 +0100
Subject: [PATCH v3 2/4] arm: bcm2835: convert to the irqchip infrastructure
In-Reply-To: <20121106165639.GF1254@beefymiracle.amer.corp.natinst.com>
References: <1351462748-5224-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121106165639.GF1254@beefymiracle.amer.corp.natinst.com>
Message-ID: <20121107080952.0594f3ef@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Josh,

On Tue, 6 Nov 2012 10:56:39 -0600, Josh Cartwright wrote:

> Could it make sense here to kill the irqchip.h private export, and
> instead rely on the linker to stitch together the builtin irqchip's
> of_device_id tables?

Yes, using yet another ELF section is another option to do that. I just
wasn't sure it was worth the effort for now, but if it is seen as
necessary, I can certainly go ahead and implement this.

I am at ELCE at the moment, so quite busy with talks, discussions...
and drinks. I'll get back to this when I get back from ELCE.

Thanks for your suggestion,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
