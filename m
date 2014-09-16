From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 16 Sep 2014 21:24:46 +0200
Subject: [PATCH 1/8] arm: Convert pr_warning to pr_warn
In-Reply-To: <1410884281.16519.2.camel@joe-AO725>
References: <cover.1410632834.git.joe@perches.com>
 <7995478e8c658478cd37dabb996f7269405251ac.1410632835.git.joe@perches.com>
 <20140915155656.GA29744@arm.com>
 <20140916160759.GJ12361@n2100.arm.linux.org.uk>
 <1410884281.16519.2.camel@joe-AO725>
Message-ID: <20140916192446.GK3755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Tue, Sep 16, 2014 at 09:18:01AM -0700, Joe Perches wrote:
> On Tue, 2014-09-16 at 17:07 +0100, Russell King - ARM Linux wrote:
> > any chance you could add a KernelVersion: tag somewhere in the
> > commit message and throw it at patches at arm.linux.org.uk so it doesn't
> > get lost?
> 
> There are no commit logs with a KernelVersion: tag
> in all of git history.
> 
> What do you think a KernelVersion: tag is and what
> would it be used for?
That's used in Russell's patch tracker, but the resulting commit doesn't
have the KernelVersion tag.

See http://www.arm.linux.org.uk/developer/patches/info.php for the
details.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
