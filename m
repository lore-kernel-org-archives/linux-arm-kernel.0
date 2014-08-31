From: tj@kernel.org (Tejun Heo)
Date: Sun, 31 Aug 2014 07:02:46 -0400
Subject: [Patch v3] 2/7] ata: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1409417172-6846-3-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
 <1409417172-6846-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140831110246.GD19853@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 30, 2014 at 06:46:07PM +0200, Andrew Lunn wrote:
> mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
> ARCH_MVEBU is sufficient.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide at vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
