From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 17 Jul 2015 10:26:46 +0200
Subject: [PATCH 0/2] Drop two more omap3 legacy board files for v4.3
 merge window
In-Reply-To: <1437047951-22300-1-git-send-email-tony@atomide.com>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
Message-ID: <20150717082645.GB9331@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 16, 2015 at 04:59:09AM -0700, Tony Lindgren wrote:
> I think we can drop these now. This just leaves n900 and ldp with
> n900 pending patches for legacy proc support.

So I guess n900 board file removal depends on the atag procfs
support in DT. What's the problem with ldp? Its DT file seem
to cover everything in the board file. I guess both of them
will finally be removed in 4.4?

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/afc5f085/attachment.sig>
