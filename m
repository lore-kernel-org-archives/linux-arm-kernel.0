From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 21 Jul 2016 08:28:50 +0200
Subject: [PATCH v2] ARM: dts: r8a7794: Correct SDHI register size
In-Reply-To: <1469058248-27880-1-git-send-email-horms+renesas@verge.net.au>
References: <1469058248-27880-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20160721062849.GD1664@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 08:44:08AM +0900, Simon Horman wrote:
> r8a7794 SDHI ch0 has SD_DMACR which is located in 0x324.
> This patch updates register size
> 
> Based on work for the r8a7790 by Kuninori Morimoto.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160721/5d9593a8/attachment.sig>
