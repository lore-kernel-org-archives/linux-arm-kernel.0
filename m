From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 22 Sep 2015 09:52:06 +0200
Subject: [PATCH] mtd: nand: sunxi: fix sunxi_nand_chips_cleanup()
In-Reply-To: <20150922001528.GL31505@google.com>
References: <1442160883-29011-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150922001528.GL31505@google.com>
Message-ID: <20150922095206.4a4d85ea@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, 21 Sep 2015 17:15:28 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Sun, Sep 13, 2015 at 06:14:43PM +0200, Boris Brezillon wrote:
> > The sunxi_nand_chips_cleanup() function is missing a call to list_del()
> > which generates a double free error.
> 
> And if you could manage to get past that...an infinite loop, no?

Right, feel free to add it in the commit message.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
