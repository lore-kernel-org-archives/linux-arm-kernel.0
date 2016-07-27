From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 27 Jul 2016 10:46:23 +0200
Subject: [PATCH 00/13] arm64: Allwinner A64 support based on sunxi-ng
In-Reply-To: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
References: <20160726203041.29366-1-maxime.ripard@free-electrons.com>
Message-ID: <20160727104623.e9ca7b708e5c6462f44a5d01@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2016 22:30:28 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> ere is the previous A64 patches made by Andre [1], reworked to use
> the new sunxi-ng clock framework.
> 
> This uses the current H3 clock code, as both are really similar. The
> first patches are just meant to rework slightly the H3 code, before
> introducing the A64-related patches.
> 
> Some WiP stuff have been removed, such as the MMC part, but this serie
> already has a decent amount of devices supported: uart, i2c, rsb, etc.
> 
> Let me know what you think,

I don't see the interest to have common code for 32bits and 64bits.
The clock driver of a SoC will never evolve, so, it is simpler to
copy the source common with the H3 into a clean A64 clock driver.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
