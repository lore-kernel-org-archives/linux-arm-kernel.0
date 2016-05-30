From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 10:37:45 +0200
Subject: [PATCH 3/5] spi: sunxi: expose maximum transfer size limit
In-Reply-To: <5fffb7eca6f4b70853d92be2403595d6d06bede7.1464130597.git.hramrach@gmail.com>
References: <cover.1464130597.git.hramrach@gmail.com>
 <5fffb7eca6f4b70853d92be2403595d6d06bede7.1464130597.git.hramrach@gmail.com>
Message-ID: <20160530083745.GG4247@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2016 at 07:25:24PM -0000, Michal Suchanek wrote:
> The sun4i spi hardware can trasfer at most 63 bytes of data without DMA
> support so report the limitation. Same on sun6i.

Is it? Is there timeouts on the A31 and later SoCs?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/4739a050/attachment.sig>
