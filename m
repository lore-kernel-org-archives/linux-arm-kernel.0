From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 13 Dec 2013 11:38:54 -0500
Subject: [PATCH 1/4] irqchip: armada-370-xp: fix IPI race condition
In-Reply-To: <20131212232327.01f4aaff@skate>
References: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1385396807-19027-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131212232327.01f4aaff@skate>
Message-ID: <20131213163854.GD2609@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomass :)

On Thu, Dec 12, 2013 at 11:23:27PM +0100, Thomas Petazzoni wrote:
> Hello Thomas,
> 
> As the irqchip maintainer, this patch, as well as the following patch
> "irqchip: armada-370-xp: fix MSI race condition" should go through your
> tree.
> 
> They have been sent for quite some time now. Is there any reason you
> haven't picked them up? I realized I only Cc'ed you when sending them
> originally, while you should have been the main recipient, maybe that
> explains why I didn't get any feedback.
> 
> Would it be possible to merge them for 3.13 ? Notice that the below
> patch should also be backported into stable kernel all the way to 3.8.

oops.  I'm maintaining an mvebu topic branch for irqchip changes, and
forgot to look in my -fixes mail folder when putting it together.  I'll
take both of these into mvebu/irqchip-fixes and send a pull request to
Thomas in a few days.

Added:

Cc: stable at vger.kernel.org # v3.8+
Fixes: 344e873e5657e8dc0 'arm: mvebu: Add IPI support via doorbells'

to this patch.

thx,

Jason.
