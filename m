From: broonie@kernel.org (Mark Brown)
Date: Fri, 17 Jul 2015 19:11:22 +0100
Subject: [PATCH 2/2] ASoC: rockchip: Add machine driver for rt5645/rt5650
 codec
In-Reply-To: <1436930143-31361-3-git-send-email-zhengxing@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
 <1436930143-31361-3-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150717181122.GT11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 11:15:43AM +0800, Xing Zheng wrote:
> From: zhengxing <zhengxing@rock-chips.com>
> 
> The driver is used for rockchip board using a rt5645/rt5650.

Same comments here, mostly good but some minor issues.  The other thing
with both of these is that you need to have a binding document for them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/23eafb79/attachment.sig>
