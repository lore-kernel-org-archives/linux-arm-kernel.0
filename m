From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Jul 2016 09:26:26 +0200
Subject: [PATCH 24/32] i2c: bcm2835: Don't complain on -EPROBE_DEFER from
 getting our clock
In-Reply-To: <1464817421-8519-25-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-25-git-send-email-kraxel@redhat.com>
Message-ID: <20160722072626.GF1605@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 11:43:33PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> Fixes dmesg spam when we just need to wait a moment for the clock
> driver to probe.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

I applied Eric's original patch now.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/805c5c05/attachment-0001.sig>
