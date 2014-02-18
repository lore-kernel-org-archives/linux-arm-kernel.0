From: tj@kernel.org (Tejun Heo)
Date: Tue, 18 Feb 2014 17:50:52 -0500
Subject: [v3.14-rc3 BUG] 1) panic and 2) SATA not working (Was Re:
 [PATCH] ATA: SATA_MV: Add missing Kconfig select statememnt)
In-Reply-To: <20140217151315.GB2765@localhost>
References: <52e00d45.5gijwyKGLiVLcCNX%fengguang.wu@intel.com>
 <1390420593-27697-1-git-send-email-andrew@lunn.ch>
 <20140129182035.GM30842@htj.dyndns.org>
 <20140217151315.GB2765@localhost>
Message-ID: <20140218225052.GH31892@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 12:13:16PM -0300, Ezequiel Garcia wrote:
> On Wed, Jan 29, 2014 at 01:20:35PM -0500, Tejun Heo wrote:
> > On Wed, Jan 22, 2014 at 08:56:33PM +0100, Andrew Lunn wrote:
> > > SATA_MV depends on GENERIC_PHY. So if SATA_MV is built in, GENERIC_PHY
> > > cannot be modular. Fixes build error found by kbuild test robot.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > 
> > Applied to libata/for-3.14-fixes.  Thanks.
> > 
> 
> Tejun, Jason:
> 
> The lack of this patch in -rc3, just made my Armada XP GP board panic.

Will push out soon.  Thanks.

-- 
tejun
