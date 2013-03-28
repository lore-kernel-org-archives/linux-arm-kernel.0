From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:10:36 +0000
Subject: [PATCH 17/46] ARM: ux500: regulators: List the MMIO camera as a
 consumer of VAUX1
In-Reply-To: <1363881583-15234-18-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-18-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328001035.GL18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:14PM +0000, Lee Jones wrote:
> The MMIO camera uses the VAUX1 as it's voltage supply.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/0e7f438d/attachment.sig>
