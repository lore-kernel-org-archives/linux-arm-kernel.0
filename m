From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 Nov 2012 22:44:59 +0100
Subject: [PATCH 2/7] clk: mvebu: add armada-370-xp CPU specific clocks
In-Reply-To: <1353014906-31566-3-git-send-email-andrew@lunn.ch>
References: <1353014906-31566-1-git-send-email-andrew@lunn.ch>
 <1353014906-31566-3-git-send-email-andrew@lunn.ch>
Message-ID: <20121115224459.3ea69329@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 15 Nov 2012 22:28:21 +0100, Andrew Lunn wrote:
> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 
> Add Armada 370/XP specific CPU clocks
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/mvebu-core-clock.txt |   18 +--

The changes to this file.

>  .../devicetree/bindings/clock/mvebu-cpu-clock.txt  |   21 +++
>  drivers/clk/mvebu/Kconfig                          |    3 +
>  drivers/clk/mvebu/Makefile                         |    1 +
>  drivers/clk/mvebu/clk-core.c                       |    4 +-

And this one don't appear to belong in this commit, do they?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
