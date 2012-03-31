From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 11:25:50 +0100
Subject: [PATCH 1/2] regulator: fix sysfs name collision between dummy
 and fixed dummy regulator
In-Reply-To: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
References: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120331102549.GC3163@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 04:33:31PM +0800, Shawn Guo wrote:
> When regulator_register_fixed() is being used to register fixed dummy
> regulator, the following line will be seen in the boot log.  And the
> sysfs entry for fixed dummy regulator is not shown.
> 
>   dummy: Failed to create debugfs directory
> 
> The patch renames the fixed dummy supply to "fixed-dummy" to avoid
> the name collision with dummy regulator.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120331/05e720e8/attachment.sig>
