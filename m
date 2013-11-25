From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Nov 2013 11:10:32 +0800
Subject: [PATCH] backlight: pwm_bl: Do not make the regulator mandatory
In-Reply-To: <20131122145224.GO14725@sirena.org.uk>
References: <20131122142231.GA1741@ulmo.nvidia.com>
 <20131122145224.GO14725@sirena.org.uk>
Message-ID: <20131125031029.GC11613@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 02:52:24PM +0000, Mark Brown wrote:
> On Fri, Nov 22, 2013 at 03:22:32PM +0100, Thierry Reding wrote:
> 
> > Cc'ing Mark Brown, perhaps he can help figure out what's causing this.
> 
> The obvious question is what kernel this is being tested on...

Hmm, I'm seeing this breakage on v3.13-rc1 now with the following line
in the kernel log.

  pwm-backlight backlight.18: dummy supplies not allowed

What's missing here?

Shawn
