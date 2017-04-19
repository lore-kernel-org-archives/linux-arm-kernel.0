From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:49:41 -0700
Subject: [GIT PULL] ARM: aspeed: devicetree for 4.12
In-Reply-To: <CACPK8Xfp+x=MGtj-eOjdU+jSgkriJ1uG8LnP4=OB97pLdbO4Vw@mail.gmail.com>
References: <CACPK8Xfp+x=MGtj-eOjdU+jSgkriJ1uG8LnP4=OB97pLdbO4Vw@mail.gmail.com>
Message-ID: <20170419134941.GD29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 12:29:12PM +0930, Joel Stanley wrote:
> Hello Arnd, Olof,
> 
> These are the Aspeed devicetree changes for 4.12.
> 
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> tags/aspeed-4.12-devicetree
> 
> for you to fetch changes up to 78a2569fa60497347babeddb24a367946e258283:
> 
>   arm: dts: aspeed: Describe ADCs for AST2400/AST2500 (2017-04-07
> 13:09:47 +0930)
> 
> ----------------------------------------------------------------
> Aspeed devicetree updates for 4.12
> 
> Updates to the device tree to include upstreamed drivers:
> 
>  - SPI flash controller
>  - Watchdog
>  - ADC
> 
> In addition we describe some of the clocks so that upstream kernels can
> boot on hardware.

Merged, thanks! Booting is always nice. :)


-Olof
