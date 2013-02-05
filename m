From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 5 Feb 2013 07:48:33 -0500
Subject: [PATCH] arm: mvebu: Add SPI flash on Armada XP-GP board
In-Reply-To: <20130205123827.GG20242@lunn.ch>
References: <1360063473-26176-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130205123827.GG20242@lunn.ch>
Message-ID: <20130205124833.GS14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Morning-ish Andrew,

On Tue, Feb 05, 2013 at 01:38:27PM +0100, Andrew Lunn wrote:
> > And don't forget to compile the SPI flash driver, CONFIG_MTD_M25P80=y
> 
> Maybe it makes sense to provide a patch to mvebu_defconfig to add 
> CONFIG_MTD_M25P80=y ?

I thought this as well, then reconsidered when he said there was nothing
on it.  So it's not really needed to boot.  I don't have a strong
opinion on it though, so =y, =m, or =n.

thx,

Jason.
