From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Dec 2017 15:55:12 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add sid for a83t
In-Reply-To: <20171219210523.10428-1-kevans91@ksu.edu>
References: <20171219210523.10428-1-kevans91@ksu.edu>
Message-ID: <20171221145512.llxvzkcrjpquhczi@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyle,

On Tue, Dec 19, 2017 at 03:05:23PM -0600, kevans91 at ksu.edu wrote:
> Allwinner a83t has a 1 KB sid block with efuse for security rootkey and
> thermal calibration data, add node to describe it.
> 
> a83t-sid is not currently supported by nvmem/sunxi-sid, but it is
> supported in an external driver for FreeBSD.
> 
> Signed-off-by: Kyle Evans <kevans91@ksu.edu>

The patch looks fine in itself, but we've had a number of issues with
the register layout (and access patterns) in the past, so I'd rather
have something that works in Linux too if possible.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171221/cf6e2c93/attachment.sig>
