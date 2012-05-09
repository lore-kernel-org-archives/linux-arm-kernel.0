From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 12:50:42 +0100
Subject: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120509115041.GM3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 07:33:05PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

I'll apply this when devm_clk_get() makes it into mainline (hopefully in
the merge window); please remind me if I forget.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/ba653b6b/attachment-0001.sig>
