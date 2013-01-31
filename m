From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 Jan 2013 15:36:34 +0800
Subject: [PATCH] Asoc: Samsung: I2S: Add support for runtime S2R
In-Reply-To: <1359547864-1057-1-git-send-email-rcsekar@samsung.com>
References: <1359547864-1057-1-git-send-email-rcsekar@samsung.com>
Message-ID: <20130131073632.GG7663@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 05:41:04PM +0530, R. Chandrasekar wrote:
> From: "R. Chandrasekar" <rcsekar@samsung.com>
> 
> This patch adds runtime suspend to resume support for I2S.
> I2S clk is disabled at suspend and enabled at resume.

Applied, thanks.  Please use subject lines appropriate to the subsystem
and keep your signoffs in order:

> Signed-off-by: R. Chandrasekar <rcsekar@samsung.com>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/9c0eda64/attachment.sig>
