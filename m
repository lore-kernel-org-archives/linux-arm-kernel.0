From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Sep 2015 09:20:26 -0700
Subject: [PATCH 2/2] Documentation: DT bindings: rockchip-i2s: add
 capture and lrck-mode
In-Reply-To: <1442979683-9441-3-git-send-email-sugar.zhang@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-3-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20150923162026.GP30445@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 11:41:23AM +0800, Sugar Zhang wrote:

> rockchip,lrck-mode: 0: rxtx separate, 1: tx share, 2: rx share.
> default use 'rxtx separate' mode.

I'm slightly confused about this property - is this covering differences
in the IP deployed on different SoCs or is it covering how the SoC is
wired into the board?  If it's for how the SoC is wired into the board
(ie, Rx and Tx wired together) then this should already be covered by
either the machine driver or the device at the other end of the link.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150923/d4a638b3/attachment.sig>
