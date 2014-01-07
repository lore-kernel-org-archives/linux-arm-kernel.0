From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 15:39:39 +0000
Subject: [PATCH 11/11] ASoC: ux500: Dramatically reduce the size of the
 DAI driver data struct
In-Reply-To: <1387468508-12286-12-git-send-email-lee.jones@linaro.org>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-12-git-send-email-lee.jones@linaro.org>
Message-ID: <20140107153939.GT31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 03:55:08PM +0000, Lee Jones wrote:
> We no longer have a means to differentiate between MSP devices at probe
> time, mainly because we don't really have to. So rather than have an over-
> sized static data structure in place, where the only difference between
> devices is the ID and name (which are unused), we'll just create one
> succinct, statically assigned and shared one instead.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/cc1a5f78/attachment.sig>
