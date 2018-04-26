From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Apr 2018 12:39:34 +0100
Subject: [PATCH 11/11] spi: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20180426113934.GB21755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:53:10AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/4fccb817/attachment.sig>
