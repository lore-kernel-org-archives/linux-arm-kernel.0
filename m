From: sre@kernel.org (Sebastian Reichel)
Date: Fri, 3 Jun 2016 04:38:53 +0200
Subject: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
In-Reply-To: <57409633.8060605@gmail.com>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com>
Message-ID: <20160603023853.GD8921@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Sat, May 21, 2016 at 10:09:07AM -0700, Florian Fainelli wrote:
> Le 11/05/2016 14:36, Chris Brand a ?crit :
> > This driver supports reset on both BCM21664 and BCM23550.
> > Code is being moved from arch/arm/mach-bcm/board_bcm21664.c
> > 
> > Signed-off-by: Chris Brand <chris.brand@broadcom.com>

> Sebastian, Dmitry, I know we are in the merge window, let me know if you
> would want me to take this patch and the 5 others in the next arm-soc
> pull request, or if you prefer to take this one in your own tree.

Feel free to queue it via arm-soc with

Acked-By: Sebastian Reichel <sre@kernel.org>

If I didn't overlook it, it's missing DT documentation, though.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160603/d5acb22a/attachment.sig>
