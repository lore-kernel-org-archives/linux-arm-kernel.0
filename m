From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Jan 2013 10:07:44 +0000
Subject: [PATCH 11/19] regmap: avoid undefined return from
 regmap_read_debugfs
In-Reply-To: <20130126100326.GK30594@opensource.wolfsonmicro.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-12-git-send-email-arnd@arndb.de>
 <20130126044219.GA10580@opensource.wolfsonmicro.com>
 <201301260917.28028.arnd@arndb.de>
 <20130126094855.GI30594@opensource.wolfsonmicro.com>
 <20130126095916.GB23505@n2100.arm.linux.org.uk>
 <20130126100326.GK30594@opensource.wolfsonmicro.com>
Message-ID: <20130126100744.GD23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 06:03:28PM +0800, Mark Brown wrote:
> On Sat, Jan 26, 2013 at 09:59:16AM +0000, Russell King - ARM Linux wrote:
> 
> > Why not code the function in a way that avoids the problem altogether?
> 
> That'd do the trick too; feel free to submit a patch...

Sorry, got other things which need doing, so if you want that expect it
sometime next month if I even remember.
