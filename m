From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 22 Mar 2013 12:04:22 +0100
Subject: [PATCH 06/46] regulator: ab8500: Separate regulator and MFD
 platform data
In-Reply-To: <1363881583-15234-7-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-7-git-send-email-lee.jones@linaro.org>
Message-ID: <20130322110421.GH22890@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:03PM +0000, Lee Jones wrote:
> From: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
> 
> The ab8500 MFD should not have knowledge about regulator-
> specific platform data like number of regulators and
> regulator registers. As the regulator platform data is
> about to grow with external regulators, this information
> is moved to a new structure provided by the regulator
> driver.

Applied everything up to here, thanks - I'll carry on reviewing the rest
later, not actually looked at them yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130322/28401a71/attachment.sig>
