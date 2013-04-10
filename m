From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Apr 2013 19:21:06 +0200
Subject: [PATCHv1 0/5] Marvell EBU irqchip improvements
In-Reply-To: <20130410130902.GA29100@localhost>
References: <1365542778-27959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130410130902.GA29100@localhost>
Message-ID: <20130410192106.73d81f2c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 10 Apr 2013 10:09:03 -0300, Ezequiel Garcia wrote:

> I'm trying to test this patchset, assuming you've based it on top of
> v3.9-rc5.
> 
> However, patch 4/5 doesn't apply and I'm not really sure which
> other patches may be depending on this.
> 
> Any hints?

The patch set is based on 3.9-rc6, with no other dependencies. However,
since a patch has been applied on the mvebu IRQ controller driver
between 3.9-rc5 and 3.9-rc6, it probably explains the fact that the
patch set doesn't apply as is on 3.9-rc5.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
