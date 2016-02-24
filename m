From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 13:36:33 -0800
Subject: [GIT PULL] NXP LPC32xx Platform Updates for v4.6 #1
In-Reply-To: <56BBE6E6.4080802@mleia.com>
References: <56BBE6E6.4080802@mleia.com>
Message-ID: <20160224213633.GF10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Thu, Feb 11, 2016 at 03:41:58AM +0200, Vladimir Zapolskiy wrote:
> Hi Arnd, Olof, Kevin,
> 
> please consider to include NXP LPC32xx platfrom updates (#1) for v4.6.
> 
> The main change is a switchover to a common clock framework driver
> for LPC32xx, this also allows to reuse a shared LPC32xx clockevent
> driver, and hence remove legacy clock and timer drivers from
> arch/arm/mach-lpc32xx.
> 
> I'm adding an official LPC32xx maintainer Roland to Cc, however
> he seems to be unresponsive for a quite long time (since 2014).
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   https://github.com/vzapolskiy/linux.git lpc32xx/soc
> 
> for you to fetch changes up to 0ac1a101f5dd28c3894be3c0230ee7ea2e05e8aa:
> 
>   arm: lpc32xx: remove direct control of GPIOs from shared mach file (2016-02-11 02:27:04 +0200)

In the future, please use the decription you wrote above as part of a tag
description, and sign your tags. For extra credit, get other kernel developers
to sign your key (easiest done at conferences, but maybe there are other
developers in your local area that you can meet up with).

It indeed seems like Roland has gone silent lately. This happens from time to
time, but it's always good to know if it's intentional (and if he's coming
back) or not. Meanwhile, we can merge patches after review but I don't have
hardware to test on so I'd have to rely on you getting that right. If we get
regression reports we'll have to re-evaluate the approach. :)

Roland, any chance we can get a word from you on this? Thanks!


-Olof
