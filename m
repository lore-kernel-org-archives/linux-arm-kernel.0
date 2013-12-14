From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 14 Dec 2013 18:35:14 +0100
Subject: [PATCH 1/4] irqchip: armada-370-xp: fix IPI race condition
In-Reply-To: <20131213163854.GD2609@titan.lakedaemon.net>
References: <1385396807-19027-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1385396807-19027-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131212232327.01f4aaff@skate>
 <20131213163854.GD2609@titan.lakedaemon.net>
Message-ID: <20131214183514.3707a4dd@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 13 Dec 2013 11:38:54 -0500, Jason Cooper wrote:

> > Would it be possible to merge them for 3.13 ? Notice that the below
> > patch should also be backported into stable kernel all the way to 3.8.
> 
> oops.  I'm maintaining an mvebu topic branch for irqchip changes, and
> forgot to look in my -fixes mail folder when putting it together.  I'll
> take both of these into mvebu/irqchip-fixes and send a pull request to
> Thomas in a few days.
> 
> Added:
> 
> Cc: stable at vger.kernel.org # v3.8+
> Fixes: 344e873e5657e8dc0 'arm: mvebu: Add IPI support via doorbells'
> 
> to this patch.

Great, thanks! Note that the patch will not apply as is on 3.8, but I
will be able to provide a backported variant of it when needed.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
