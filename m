From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 00:02:06 +0000
Subject: SA110 MMU problem, any hints?
In-Reply-To: <CACRpkdaph0_mnJsDBC7_5+wWm18cygf70GoJ-QR0fPuyN0Xw=A@mail.gmail.com>
References: <CACRpkdaph0_mnJsDBC7_5+wWm18cygf70GoJ-QR0fPuyN0Xw=A@mail.gmail.com>
Message-ID: <20140226000206.GT21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 12:49:40AM +0100, Linus Walleij wrote:
> Hi Russell,
> 
> after doing some painful bringup on a Netwinder
> machine, I have run into an unspecified MMU bug on the SA110.
> Basically the kernel bootstrap bugs out before start_kernel()
> so it's on a very basic level.
> 
> If I turn off CONFIG_MMU it actually boots all the way until attempting
> to mount root, with boot logo, VGA console and everything.
> 
> Given  that you made some Footbridge patches recently I guess
> you have it working? No special tweaks?

3.12 and 3.12.6 runs fine here on two different footbridge platforms.
I haven't tried it on the netwinder though (they're a little noisy in
comparison with other stuff.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
