From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 Jul 2012 12:57:49 +0100
Subject: [PATCH 04/21] ASoC: ux500: Strengthen error checking after
 memory allocation
In-Reply-To: <1343298534-13611-5-git-send-email-lee.jones@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org>
 <1343298534-13611-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20120726115749.GF3099@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 11:28:37AM +0100, Lee Jones wrote:
> Currently there is no out-of-memory error checking after attempting
> to allocate memory for the ux500_msp or ux500_msp_i2s_drvdata data
> structures. Instead we go about populating them regardless. This
> patch applies the necessary error checking to prevent a panic.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/e56f8fb7/attachment.sig>
