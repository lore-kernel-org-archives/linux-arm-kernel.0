From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Aug 2014 12:08:03 +0100
Subject: [PATCH] spi/rockchip: Avoid accidentally turning off the clock
In-Reply-To: <1409269428-24680-1-git-send-email-dianders@chromium.org>
References: <1409269428-24680-1-git-send-email-dianders@chromium.org>
Message-ID: <20140829110803.GO29327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 04:43:48PM -0700, Doug Anderson wrote:
> If our client is requesting a clock that is above the maximum clock
> then the following division will result in 0:
>   rs->max_freq / rs->speed

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140829/8107a85b/attachment.sig>
