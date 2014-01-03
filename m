From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Jan 2014 16:47:58 +0100
Subject: [PATCH 01/15] i2c: shmobile/rcar: Restrict non-COMPILE_TEST
 compilation
In-Reply-To: <1385515117-23664-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140103154758.GF7132@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 02:18:23AM +0100, Laurent Pinchart wrote:
> Hardware supported by the i2c sh_mobile and rcar drivers is only found
> on SUPERH or ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST
> compilation to them.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/7f3e244d/attachment.sig>
