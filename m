From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jul 2015 20:04:59 +0100
Subject: [PATCH 2/3] regulator: 88pm800: fix LDO vsel_mask value
In-Reply-To: <1436445692-10656-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1436445692-10656-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436445692-10656-3-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <20150709190459.GP11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 06:11:31PM +0530, Vaibhav Hiremath wrote:
> From: Yi Zhang <yizhang@marvell.com>
> 
> As per datasheet,
> Except LDO2, all other LDO's use bit [3:0] for VOUT select.

Bug fixes like this should come at the start of the series before new
functionality so they can be merged as bug fixes into Linus' tree and
-stable.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150709/9051c207/attachment.sig>
