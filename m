From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:11:17 +0000
Subject: [PATCH 18/46] regulator: ab8500: Clean out SoC registers
In-Reply-To: <1363881583-15234-19-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-19-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328001117.GM18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:15PM +0000, Lee Jones wrote:
> Clean out initialisation that is handled by SoC. Regulator
> settings for Vpll (partly), Vsmps1, Vsmps2, Vsmps3 (partly),
> Vrf1, Varm, Vape, Vbb, Vmod are cleaned out. They should not
> be touched by the kernel.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/7c86fb73/attachment.sig>
