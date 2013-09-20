From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Sep 2013 12:44:33 -0500
Subject: [PATCH 1/1] ARM: dts: am335x-bone-common: correct mux mode for
 mmc1_cmd
In-Reply-To: <1379698696-21945-1-git-send-email-balajitk@ti.com>
References: <1379698696-21945-1-git-send-email-balajitk@ti.com>
Message-ID: <20130920174433.GL18721@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 11:08:16PM +0530, Balaji T K wrote:
> correct mux mode for mmc1_cmd to detect eMMC on bone-black
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>

Tested on my BBB, I see that after this patch eMMC gets detected just
fine:

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/bc24bfdb/attachment.sig>
