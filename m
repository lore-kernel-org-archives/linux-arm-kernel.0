From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Mar 2013 00:15:07 +0000
Subject: [PATCH 24/46] ARM: ux500: regulator: Add accelerometer and fix
 magnetometer supply device ID
In-Reply-To: <1363881583-15234-25-git-send-email-lee.jones@linaro.org>
References: <1363881583-15234-1-git-send-email-lee.jones@linaro.org>
 <1363881583-15234-25-git-send-email-lee.jones@linaro.org>
Message-ID: <20130328001506.GO18316@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 03:59:21PM +0000, Lee Jones wrote:
> This patch adds the LSM303DLHC Accelerometer to the list of VAUX1
> consumers, as well as amending the already added LSM303DLHC
> Magnetometer's device ID.

Applied, though this looks suspicously like it's bugfixing an earlier
commit in the series...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130328/6ca999b8/attachment.sig>
