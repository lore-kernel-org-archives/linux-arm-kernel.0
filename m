From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 4 Feb 2013 13:37:33 -0500
Subject: [PATCH 0/2] ARM: mvebu: Add support for SPI controller in
 Armada 370/XP
In-Reply-To: <20130204165119.GA2440@localhost>
References: <1359995888-2385-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130204165119.GA2440@localhost>
Message-ID: <20130204183733.GM14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ezequiel,

This series looks good.  just a few comments:

On Mon, Feb 04, 2013 at 01:51:20PM -0300, Ezequiel Garcia wrote:
> Hi,
> 
> This patchset adds support for the SPI controller
> available in Armada 370 and Armada XP SoC.
> 
> The patches are based in Jason Cooper's mvebu/dt branch.

It probably doesn't matter for this series (I haven't tried to apply it
yet), but please base future work off of a mainline tag (eg v3.8-rc6).
It makes merge conflicts easier to resolve.

Feel free to test-merge against the mvebu/ branches and let me know of
any conflicts.

Also, your patch series appears to be out of order, did you use git
send-email once per file?

thx,

Jason.
