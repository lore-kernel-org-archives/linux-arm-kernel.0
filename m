From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Sep 2012 22:40:30 -0400
Subject: [PATCH v2] ARM: initial DTS support for km_kirkwood
In-Reply-To: <1346752502-30862-1-git-send-email-valentin.longchamp@keymile.com>
References: <1346752502-30862-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20120910024030.GT4575@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 11:55:02AM +0200, Valentin Longchamp wrote:
> This is a first attempt to support the km_kirkwood reference design with
> a device tree. This km_kirkwood design is present in many Keymile
> products. It is based on the Marvell Bobcat SOC which integrates a
> Kirkwood CPU next to a big L2 Ethernet Switch. The Kirkwood in the SOC
> is very similar to the "normal" one, but there are a few differences.
> 
> This initial support is minimal: the kernel can boot with network
> (ge0), serial port and NAND functional.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> Cc: Holger Brunck <holger.brunck@keymile.com>

Applied to:

git://git.infradead.org/users/jcooper/linux.git kirkwood/boards

thx,

Jason.
