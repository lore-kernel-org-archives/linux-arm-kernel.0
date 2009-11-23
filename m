From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 23 Nov 2009 23:11:43 +0000
Subject: [PATCH v2] i2c-designware updates
In-Reply-To: <4AF419B6.1000802@necel.com>
References: <4AF419B6.1000802@necel.com>
Message-ID: <20091123231143.GA32202@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2009 at 09:42:30PM +0900, Shinya Kuribayashi wrote:
> Hi Baruch and Ben,
> 
> here's v2 patchset of DesignWare I2C driver (i2c-designware.c).
> I did all test I can do for now (including arbitration tests), and
> fixed more issues left in the v1 patchset.  I think now the driver is
> in reasonable shape for the mainline, and hope gets merged.
> 
> The patches which already have Baruch's Acked-by: line are logically
> same as the previous v1 patches.  For the rest are revised version of
> v1 patches, or newly added in v2.
> 
> There are 22 patches in total and might be slightly annoying.  I'll
> send subsequent patches only to linux-i2c.

These are all queued at:

	git://git.fluff.org/bjdooks/linux.git next-i2c-designware

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
