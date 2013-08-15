From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 15 Aug 2013 16:15:54 +0200
Subject: [PATCH 1/8] i2c: imx: use struct representing i2c clk{div, val}
 pair
In-Reply-To: <1375866343-2074-1-git-send-email-b35083@freescale.com>
References: <1375866343-2074-1-git-send-email-b35083@freescale.com>
Message-ID: <20130815141554.GL17155@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 05:05:36PM +0800, Jingchang Lu wrote:
> using struct representing the i2c clk{div, val} pair would
> make the i2c_clk_div array more clear.
> 
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Applied series to for-next, thanks! Please use --cover-letter next time.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130815/5ff52d7b/attachment.sig>
