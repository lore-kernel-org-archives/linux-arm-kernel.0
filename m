From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 23 Jan 2014 09:04:48 -0300
Subject: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
In-Reply-To: <20140123001934.GY18269@obsidianresearch.com>
References: <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
 <20140122205213.GW18269@obsidianresearch.com>
 <20140122221237.GA30763@localhost>
 <20140122223117.GX18269@obsidianresearch.com>
 <52E05C4E.9060709@gmail.com>
 <20140123001934.GY18269@obsidianresearch.com>
Message-ID: <20140123120447.GD6065@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 05:19:34PM -0700, Jason Gunthorpe wrote:
[..]
> 
> On Kirkwood this means all of the main interrupt controller bits are
> level and all the bridge bits are edge. Which means edge is
> definitely correct for the bridge handler, and level correct for the
> main handler.
> 

Which means we should change the bridge handler to edge?

Is there any _noticeable_ side-effect in doing the handling via level?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
