From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Apr 2013 13:31:40 +0200
Subject: [PATCH v6 0/3] of/pci: Provide common support for PCI DT parsing
In-Reply-To: <20130416112951.GZ28693@titan.lakedaemon.net>
References: <1365693969-23907-1-git-send-email-Andrew.Murray@arm.com>
 <20130415175641.GM28693@titan.lakedaemon.net>
 <CACRpkdbSd8pRG5pUS0ymqXDSp=ZhoQa2ctVuRA0cCmUcX5qFAA@mail.gmail.com>
 <1366096361.24994.49.camel@pasglop>
 <20130416112951.GZ28693@titan.lakedaemon.net>
Message-ID: <20130416133140.7de24c89@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 16 Apr 2013 07:29:51 -0400, Jason Cooper wrote:

> > Do not send this series upstream (or even in -next) until it has been at
> > least build-tested and acked by the affected architectures. AFAIK it
> > breaks microblaze build (simple missing #include) and isn't yet tested
> > on powerpc (I'm on vacation, maybe somebody else on linuxppc-dev can do
> > it though).
> 
> I added the missing include reference by Michal Simek for the branch at
> mvebu/drivers.

Some other build issues were reported on x86 during the night (thanks
to automated build tests), and Andrew Murray has just sent a new
version v7 of the patch set addressing those issues, as well as the
missing include.

Also, please note that Andrew's patch set contains three patches, but
the Marvell PCIe driver only requires PATCH 1/3 and PATCH 2/3.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
