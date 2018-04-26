From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 26 Apr 2018 11:03:05 +0200
Subject: [PATCH 08/11] i2c: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-9-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20180426090305.gusouz4dly5ozr5y@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2018 at 10:53:07AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/33c4326d/attachment-0001.sig>
