From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 7 Nov 2016 01:36:39 +0100
Subject: [PATCH v4 0/7] i2c: bcm2835: Bring in changes from downstream
In-Reply-To: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
References: <1475525174-28604-1-git-send-email-noralf@tronnes.org>
Message-ID: <20161107003639.GC1442@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 10:06:07PM +0200, Noralf Tr?nnes wrote:

> This patchset tries to bring in the lessons learned in the downstream
> driver i2c-bcm2708. The downstream clock stretcing timeout patch has
> been left out since clock stretching is broken/unreliable on this
> controller, so no point in setting it.
> 
> Changes since version 3:
> - Add comment about I2C_C_CLEAR on error

Looks like some serious hacking to get around HW limitations. Thanks for
upporting it.

Applied to for-next.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/3c095562/attachment.sig>
