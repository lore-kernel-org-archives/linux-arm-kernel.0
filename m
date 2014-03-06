From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Mar 2014 12:45:32 +0800
Subject: [PATCH 3/8] spi: pl022: Let runtime PM callbacks be available
 for CONFIG_PM
In-Reply-To: <1393671371-2398-4-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <1393671371-2398-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140306044532.GG13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 11:56:06AM +0100, Ulf Hansson wrote:
> Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
> callbacks. This means the callbacks becomes available for both
> CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
> combinations of these scenarios.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/58aee6a0/attachment-0001.sig>
