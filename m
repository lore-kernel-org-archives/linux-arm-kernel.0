From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 17:58:38 +0100
Subject: [PATCH 12/15] drivers/regulator: ab8500: Split up probe() into
 manageable pieces
In-Reply-To: <1336155805-18554-13-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-13-git-send-email-lee.jones@linaro.org>
Message-ID: <20120507165838.GN17002@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 07:23:22PM +0100, Lee Jones wrote:
> ab8500's probe() function is becoming quite large, so in the lead
> up to Device Tree enablement which will fork the thread of execution

This doesn't apply against current regulator code.  Please also at least
try to use changelogs that match the subsystem you're submitting
against.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/6b2965d7/attachment.sig>
