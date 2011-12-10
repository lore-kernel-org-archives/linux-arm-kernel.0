From: sre@debian.org (Sebastian Reichel)
Date: Sat, 10 Dec 2011 09:37:03 +0100
Subject: [PATCH v2] omap: rx51: fix USB
In-Reply-To: <1323375780-13190-1-git-send-email-felipe.contreras@nokia.com>
References: <20111208144044.GA25415@xps8300>
 <1323375780-13190-1-git-send-email-felipe.contreras@nokia.com>
Message-ID: <20111210083702.GB32605@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 10:23:00PM +0200, Felipe Contreras wrote:
> The transceiver should be powered on by default, otherwise USB doesn't
> work at all.
> 
> All kernels after v3.0 are affected.

I tested this patch successfully on 3.1 mainline kernel.
You can add this if you want:

Reviewed-by: Sebastian Reichel <sre@debian.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111210/b1262b1d/attachment.sig>
