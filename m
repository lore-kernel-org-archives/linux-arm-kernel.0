From: cjb@laptop.org (Chris Ball)
Date: Fri, 27 Aug 2010 20:00:34 +0100
Subject: [PATCH] MMC: pxamci: call pdata->setpower even when regulator
	is used
In-Reply-To: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
References: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Message-ID: <20100827190034.GA20407@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 26, 2009 at 12:10:13PM +0100, Daniel Mack wrote:
> On platforms where the vmmc regulator is used, it might still be
> necessary to call the platform data's setpower() callback in order to
> drive GPIOs to power up hardware.
> 
> I can't see any pxamci user with power regulators enabled, hence this
> shouldn't break anything.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>

Am chasing up old patches, looks like this didn't get merged.  Eric,
any interest in taking something like this, or was your reply a NACK?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
