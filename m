From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 21 Dec 2017 23:07:14 +0800
Subject: [PATCH v2] ARM: dts: sunxi: Add sid for a83t
In-Reply-To: <20171221145512.llxvzkcrjpquhczi@flea.lan>
References: <20171219210523.10428-1-kevans91@ksu.edu>
 <20171221145512.llxvzkcrjpquhczi@flea.lan>
Message-ID: <23300841.b4klJayR8J@ice-x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017?12?21???? CST ??10:55:12?Maxime Ripard ???
> Hi Kyle,
> 
> On Tue, Dec 19, 2017 at 03:05:23PM -0600, kevans91 at ksu.edu wrote:
> > Allwinner a83t has a 1 KB sid block with efuse for security rootkey and
> > thermal calibration data, add node to describe it.
> > 
> > a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
> > supported in an external driver for FreeBSD.
> > 
> > Signed-off-by: Kyle Evans <kevans91@ksu.edu>
> 
> The patch looks fine in itself, but we've had a number of issues with
> the register layout (and access patterns) in the past, so I'd rather
> have something that works in Linux too if possible.

I think for A83T it can just refer H3.

> 
> Maxime
