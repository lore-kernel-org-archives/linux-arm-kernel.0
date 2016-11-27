From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Nov 2016 22:39:12 +0100
Subject: [PATCH] mv88e6xxx: Fix mv88e6xxx_g1_irq_free() interrupt count
In-Reply-To: <ff0d121a-0ecb-8af7-af11-cf94df31639c@suse.de>
References: <1480279424-7830-1-git-send-email-afaerber@suse.de>
 <20161127212256.GC13318@lunn.ch>
 <ff0d121a-0ecb-8af7-af11-cf94df31639c@suse.de>
Message-ID: <20161127213912.GG13318@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 10:32:41PM +0100, Andreas F?rber wrote:
> Hi Andrew,
> 
> Am 27.11.2016 um 22:22 schrieb Andrew Lunn:
> > On Sun, Nov 27, 2016 at 09:43:44PM +0100, Andreas F?rber wrote:
> >> mv88e6xxx_g1_irq_setup() sets up chip->g1_irq.nirqs interrupt mappings,
> >> so free the same amount. This will be 8 or 9 in practice, less than 16.
> > 
> > Hi Andreas
> > 
> > The patch is correct, but please read
> > Documentation/networking/netdev-FAQ.txt
> > and then resubmit the patch.
> 
> Do you mean --subject-prefix="PATCH net-next"

Yep.

Thanks
	Andrew
