From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 8 Feb 2018 00:11:56 +0100
Subject: [RFC v4 14/26] ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
In-Reply-To: <1517423070-24236-15-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-15-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180207231156.3o2eeymgb7eec3e3@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:24:18PM +0000, Fabrizio Castro wrote:
> R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
> its driver by default.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Given the rest of the series works (same for the later patches):

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/16dbfbd5/attachment-0001.sig>
