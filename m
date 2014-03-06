From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Mar 2014 12:45:49 +0800
Subject: [PATCH 4/8] spi: pl022: Don't ignore power domain and amba bus
 at system suspend
In-Reply-To: <1393671371-2398-5-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <1393671371-2398-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140306044549.GH13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 11:56:07AM +0100, Ulf Hansson wrote:
> Previously only the resources controlled by the driver were put into
> low power state at system suspend. Both the amba bus and a potential
> power domain were ignored.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/0960093d/attachment.sig>
