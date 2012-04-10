From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Apr 2012 09:35:36 +0100
Subject: questions about drivers/dma/amba-pl08x.c
In-Reply-To: <CACRpkdaC3=vSGF6XH=7Oiqsdg0RVDfbv-M5NZDY5psF96BssHQ@mail.gmail.com>
References: <CAKwPUozgACvV-TZdn92f1O2shSEvFBfbN-hrS=FNQ5O+DEEY5g@mail.gmail.com>
 <CACRpkdaC3=vSGF6XH=7Oiqsdg0RVDfbv-M5NZDY5psF96BssHQ@mail.gmail.com>
Message-ID: <20120410083536.GL24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 10:32:20AM +0200, Linus Walleij wrote:
> Sorry, I'm not following, so slave is true and there is still no slave
> channels defined? It looks like your platform data is wrong.
> 
> But better error checking is always needed so if you want to,
> please send a patch to improve it...

Or we could just say that if people want to point the gun at their feet
and pull the trigger, we shouldn't detect that and stop the bullet coming
out the barrel.
