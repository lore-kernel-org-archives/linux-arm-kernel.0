From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 29 Jun 2016 01:47:45 +0200
Subject: [PATCH] power: qcom_smbb: Make an extcon for usb cable detection
In-Reply-To: <20160626055437.18516-1-stephen.boyd@linaro.org>
References: <20160626055437.18516-1-stephen.boyd@linaro.org>
Message-ID: <20160628234744.GA13733@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jun 25, 2016 at 10:54:37PM -0700, Stephen Boyd wrote:
> On these PMICs the usb cable connection/disconnection is
> indicated by the usb-valid interrupt being high or low
> respectively. Let's make an extcon for that, so we can notify usb
> drivers of the cable state.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160629/84bdebdd/attachment.sig>
