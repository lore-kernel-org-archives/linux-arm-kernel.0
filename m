From: tony@atomide.com (Tony Lindgren)
Date: Mon, 18 Nov 2013 10:57:23 -0800
Subject: [BUG] PandaBoard hangs before starting init while booting v3.12
In-Reply-To: <87hab9agjr.fsf@gmail.com>
References: <87hab9agjr.fsf@gmail.com>
Message-ID: <20131118185722.GS10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ben Gamari <bgamari.foss@gmail.com> [131118 07:14]:
> I'm having difficulty getting a PandaBoard ES rev. B1 to boot v3.12 and
> linux-next (30121118). I'm booting with a brand new u-boot
> (c2e5e802ecb7ab668ce9911b210ed68c804b349f).
> 
> In both cases the device appears to hang shortly before one would expect
> init to start as seen in the boot output below. I'm booting with the
> omap4-panda-es devicetree. As far as I can tell, the machine is
> completely dead and will not respond to even sysrq. I have a PandaBoard
> A4 which apparently has no trouble with the same kernel image.

Do you have the same version of u-boot in both cases?

Regards,

Tony
