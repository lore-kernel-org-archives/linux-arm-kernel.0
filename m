From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Sep 2012 14:54:31 +0200
Subject: [PATCH 1/5] arm: plat-orion: use 'void __iomem *' in addr-map code
In-Reply-To: <20120909204519.GL4575@titan.lakedaemon.net>
References: <1344003237-13575-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1344003237-13575-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120909204519.GL4575@titan.lakedaemon.net>
Message-ID: <20120911145431.31a5a9e0@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Le Sun, 9 Sep 2012 16:45:19 -0400,
Jason Cooper <jason@lakedaemon.net> a ?crit :

> I just wanted to make sure this came to your attention.  While
> discussing the finer points of branch management for pull requests,
> Olof had the following comments regarding this patch:
> 
> > >       arm: plat-orion: use 'void __iomem *' in addr-map code
> > 
> > Hmm, I would prefer if the actual constants were annotated instead
> > of cast in the code here. See how we handled that on tegra with
> > IOMEM(). That will also help sparse catch unannotated uses of those
> > constants.
> 
> Could you please take a look at this?  I assume the rest of this
> series relies on this patch, so I'm holding off until it's resolved.

Sorry for the delay, I was busy working on the Marvell Armada
370/XP network driver. I have now posted a 17 patches series that
should hopefully address Olof's comment (version 4 of this patch
series).

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
