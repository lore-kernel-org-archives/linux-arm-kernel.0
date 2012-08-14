From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 19:22:56 -0400
Subject: [PATCH v2 1/2] ARM: kirkwood: DT board setup for Seagate
 FreeAgent Dockstar
In-Reply-To: <1344977022-29037-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <20120814193613.GS22226@titan.lakedaemon.net>
 <1344977022-29037-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120814232256.GX22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 10:43:41PM +0200, Sebastian Hesselbarth wrote:
> This add a DT compatible board specific setup for the Seagate
> FreeAgent Dockstar.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> 
> v2: rebased on git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

patches [1/2] and [2/2] of this series applied to:

  git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7

patch [2/2] depends upon:

  bda63c1 ARM: Kirkwood: fix Makefile.boot

which should be in an upcoming v3.6-rc

thx,

Jason.
