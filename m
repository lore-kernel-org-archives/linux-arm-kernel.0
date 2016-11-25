From: moinejf@gmail.com (=?ISO-8859-1?Q?Jean-Fran=E7ois?= Moine)
Date: Fri, 25 Nov 2016 07:57:32 +0100
Subject: [linux-sunxi] [PATCH v6 3/5] ARM: dts: sun8i-h3: add HDMI video
 nodes
In-Reply-To: <6896101480051640@web28h.yandex.ru>
References: <cover.1479641523.git.moinejf@free.fr>
 <cdf50b8433e2d9a053e35f8788bfcd5d41504312.1479641523.git.moinejf@free.fr>
 <6896101480051640@web28h.yandex.ru>
Message-ID: <20161125075732.a2bdb9908bb9d5de7edb41a8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Nov 2016 13:27:20 +0800
Icenowy Zheng <icenowy@aosc.xyz> wrote:

> > + assigned-clocks = <&ccu CLK_PLL_DE>,
> 
> Cannot get the patch built on 4.9-rc, as CLK_PLL_DE is not an exported clock.

Hi,

Sorry, I forgot it. The symbol goes to
include/dt-bindings/clock/sun8i-h3-ccu.h
as:

#define CLK_PLL_DE		13

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
