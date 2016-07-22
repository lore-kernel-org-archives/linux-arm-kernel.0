From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 22 Jul 2016 09:26:08 +0200
Subject: [PATCH 28/32] i2c: bcm2835: Set up the rising/falling edge delays.
In-Reply-To: <1464817421-8519-29-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
 <1464817421-8519-29-git-send-email-kraxel@redhat.com>
Message-ID: <20160722072608.GE1605@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 11:43:37PM +0200, Gerd Hoffmann wrote:
> From: Eric Anholt <eric@anholt.net>
> 
> We were leaving them in the power on state (or the state the firmware
> had set up for some client, if we were taking over from them).  The
> boot state was 30 core clocks, when we actually want to sample some
> time after (to make sure that the new input bit has actually arrived).
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>

Gerd, your Signed-off is missing here.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160722/13315344/attachment.sig>
