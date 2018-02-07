From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 8 Feb 2018 00:12:06 +0100
Subject: [RFC v4 15/26] clk: renesas: r8a7743: Add rwdt clock
In-Reply-To: <1517423070-24236-16-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-16-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180207231206.qnbl65q5i6op4xyf@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 06:24:19PM +0000, Fabrizio Castro wrote:
> Add "rwdt" clock to r8a7743_mod_clks. Also, since we may need to access
> the watchdog registers at any time, declare the clock as critical.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180208/c8e83d33/attachment-0001.sig>
